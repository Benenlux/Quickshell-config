//Shamelessly stolen from caelestia-dots https://github.com/caelestia-dots/shell

pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property real stepSize: 0.1

    property list<var> ddcMonitors: []
    readonly property list<Monitor> monitors: variants.instances
    property bool appleDisplayPresent: false

    Component.onCompleted: console.log("[Brightness] Singleton loaded. Screens found:", Quickshell.screens.length)

    function getMonitorForScreen(screen: ShellScreen): var {
        if (!screen) return null;
        return monitors.find(m => m.modelData === screen);
    }

    function getMonitor(query: string): var {
        if (query === "active") {
            const focusedMonitor = Hyprland.monitors.find(m => m.focused);
            if (!focusedMonitor) return null;
            return monitors.find(m => m.modelData.name === focusedMonitor.name);
        }
        if (query.startsWith("model:")) {
            return monitors.find(m => m.modelData.model === query.slice(6));
        }
        return monitors.find(m => m.modelData.name === query);
    }

    Variants {
        id: variants
        model: Quickshell.screens
        delegate: Monitor {
            modelData: modelData
        }
    }

    component Monitor: QtObject {
        id: monitor
        required property ShellScreen modelData
        
        readonly property bool isDdc: root.ddcMonitors.some(m => m.rawConnector.includes(modelData.name))
        readonly property string busNum: {
            const match = root.ddcMonitors.find(m => m.rawConnector.includes(modelData.name));
            return match ? match.busNum : "";
        }
        readonly property bool isAppleDisplay: root.appleDisplayPresent && modelData.model.startsWith("StudioDisplay")
        
        property real brightness: 0.0
        property real queuedBrightness: NaN

        readonly property Process initProc: Process {
            stdout: StdioCollector {
                onStreamFinished: {
                    const output = text.trim();
                    console.log(`[Brightness] Init for ${monitor.modelData.name} (${monitor.isDdc ? "DDC" : "Native"}). Output: ${output}`);

                    // 1. Apple Display
                    if (monitor.isAppleDisplay) {
                        const val = parseInt(output);
                        monitor.brightness = val / 101;
                    
                    // 2. External DDC Monitor
                    } else if (monitor.isDdc) {
                        // Output format: "VCP 10 C 50 100" (Code, Current, Max)
                        const parts = output.split(/\s+/);
                        if (parts.length >= 5) {
                            const current = parseFloat(parts[3]);
                            const max = parseFloat(parts[4]);
                            if (max > 0) monitor.brightness = current / max;
                        }

                    // 3. Native Laptop / Standard Screen
                    } else {
                        // Output format: "50 255" (Current, Max)
                        const parts = output.split(" ");
                        if (parts.length >= 2) {
                            const cur = parseFloat(parts[parts.length-2]);
                            const max = parseFloat(parts[parts.length-1]);
                            if (max > 0) monitor.brightness = cur / max;
                        }
                    }
                }
            }
        }

        readonly property Timer timer: Timer {
            interval: 500
            onTriggered: {
                if (!isNaN(monitor.queuedBrightness)) {
                    monitor.setBrightness(monitor.queuedBrightness);
                    monitor.queuedBrightness = NaN;
                }
            }
        }

        function setBrightness(value: real): void {
            value = Math.max(0, Math.min(1, value));
            const rounded = Math.round(value * 100);
            
            if (Math.round(brightness * 100) === rounded) return;

            if (isDdc && timer.running) {
                queuedBrightness = value;
                return;
            }

            brightness = value;
            console.log(`[Brightness] Setting ${modelData.name} to ${rounded}%`);

            if (isAppleDisplay)
                Quickshell.execDetached(["asdbctl", "set", rounded]);
            else if (isDdc)
                Quickshell.execDetached(["ddcutil", "-b", busNum, "setvcp", "10", rounded]);
            else
                Quickshell.execDetached(["brightnessctl", "set", `${rounded}%`]);

            if (isDdc) timer.restart();
        }

        function initBrightness(): void {
            if (isAppleDisplay)
                initProc.command = ["asdbctl", "get"];
            else if (isDdc)
                initProc.command = ["ddcutil", "-b", busNum, "getvcp", "10", "--brief"];
            else
                // Laptop: Ensure we get two numbers (current and max)
                initProc.command = ["sh", "-c", "echo $(brightnessctl g) $(brightnessctl m)"];
            
            initProc.running = true;
        }

        onBusNumChanged: initBrightness()
        Component.onCompleted: initBrightness()
    }

    // --- Hardware Detection ---
    
    Process {
        running: true
        command: ["sh", "-c", "asdbctl get 2>/dev/null || echo ''"] 
        stdout: StdioCollector { onStreamFinished: root.appleDisplayPresent = text.trim().length > 0 }
    }

    Process {
        id: ddcProc
        running: true
        command: ["ddcutil", "detect", "--brief"]
        stdout: StdioCollector {
            onStreamFinished: {
                const chunks = text.trim().split("\n\n");
                const found = [];
                for (let i = 0; i < chunks.length; i++) {
                     const d = chunks[i];
                     if (!d.startsWith("Display ")) continue;
                     
                     const busMatch = d.match(/I2C bus:[ ]*\/dev\/i2c-([0-9]+)/);
                     const cardMatch = d.match(/DRM connector:\s+(.*)/);
                     
                     if (busMatch && cardMatch) {
                         found.push({
                             busNum: busMatch[1],
                             rawConnector: cardMatch[1]
                         });
                     }
                }
                root.ddcMonitors = found;
                console.log("[Brightness] DDC Raw Data:", JSON.stringify(found));
            }
        }
    }

    // --- IPC Handler ---
    IpcHandler {
        target: "brightness"
        function set(value: string): string {
            const monitor = root.getMonitor("active");
            if (!monitor) return "No active monitor found";
            
            let target = monitor.brightness;
            if (value.endsWith("%-")) target -= parseFloat(value) / 100;
            else if (value.endsWith("%+")) target += parseFloat(value) / 100;
            else if (value.startsWith("+") && value.endsWith("%")) target += parseFloat(value.slice(1)) / 100;
            else if (value.endsWith("%")) target = parseFloat(value) / 100;
            
            monitor.setBrightness(target);
            return `Set to ${Math.round(target*100)}%`;
        }
    }
}