pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: root

    // The property we want to read elsewhere
    property int strength: 0
    property string ssid: "Disconnected"

    Process {
        id: strengthProc
        command: ["nmcli", "-t", "-f", "active,ssid,signal", "device", "wifi"]
        running: true
        stdout: StdioCollector {
            id: collector
        }

        // 3. Parse ONLY when the process is completely finished
        onExited: {
            var output = collector.text; // Get the full collected string
            if (!output)
                return;
            var lines = output.split("\n");

            // Find the active line (e.g., "yes:MyWifi:80")
            var activeLine = lines.find(line => line.startsWith("yes"));

            if (activeLine) {
                var parts = activeLine.split(":");
                // parts[1] is SSID, parts[2] is Signal Strength
                root.ssid = parts[1];
                root.strength = parseInt(parts[2]);
            } else {
                root.strength = 0;
                root.ssid = "Disconnected";
            }
        }
    }
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: strengthProc.running = true
    }
}
