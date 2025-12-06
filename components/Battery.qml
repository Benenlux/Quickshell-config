import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower // <--- Required for Battery Data
import ".." // Import AppStyle (if you have it)

Item {
    id: root

    // 1. Get the main battery device
    property var battery: UPower.displayDevice
    property var percentage: battery.percentage * 100
    // 2. Helper to determine color based on percentage
    // Returns a base color (Red, Orange, or Green)
    property color baseColor: {
        if (percentage <= 20)
            return "#fb4934"; // Red (Low)
        if (percentage <= 50)
            return "#d79921"; // Yellow/Orange (Med)
        return "#b8bb26"; // Green (High)
    }

    implicitWidth: 100
    implicitHeight: 14

    // Background (The "Empty" part of the bar)
    Rectangle {
        anchors.fill: parent
        color: "#3c3836" // Dark gray background
        radius: 6

        // Foreground (The "Filled" part)
        Rectangle {
            id: fill
            height: parent.height
            radius: 6

            // 3. Calculate Width
            // UPower percentage is usually 0-100. We clamp it just in case.
            width: parent.width * (Math.min(percentage, 100) / 100)

            // 4. The Gradient Effect
            gradient: Gradient {
                orientation: Gradient.Horizontal

                // Left side: Slightly darker version of the base color
                GradientStop {
                    position: 0.0
                    color: Qt.darker(root.baseColor, 1.2)
                }

                // Right side: The pure base color
                GradientStop {
                    position: 1.0
                    color: root.baseColor
                }
            }

            // Optional: Animation when level changes
            Behavior on width {
                NumberAnimation {
                    duration: 500
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }

        // 5. Text Label Overlay (e.g. "54%")
        Text {
            anchors.centerIn: parent
            text: percentage + "%"
            color: "white"
            font.bold: true
            font.pixelSize: 12
            renderType: Text.NativeRendering

            // Add a slight shadow so text is readable on bright yellow
            style: Text.Outline
            styleColor: "black"
        }
    }
}
