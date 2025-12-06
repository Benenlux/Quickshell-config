import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import ".."

Item {
    id: root

    // 1. Get the main battery device
    property var battery: UPower.displayDevice
    property var percentage: Math.min(battery.percentage * 100)
    property color baseColor: {
        if (percentage <= 20)
            return AppStyle.red_dim; // Red (Low)
        if (percentage <= 50)
            return AppStyle.orange_dim; // Yellow/Orange (Med)
        return AppStyle.green_dim; // Green (High)
    }

    implicitWidth: 15
    implicitHeight: 35

    // Background (The "Empty" part of the bar)
    Rectangle {
        anchors.fill: parent
        color: "#3c3836"
        radius: 6

        Item {
            id: mask
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: root.height * (Math.min(percentage, 100) / 100)

            clip: true

            // Animation for smooth movement
            Behavior on height {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }

            // 3. The Full-Size Gradient Bar
            // This stays full size so the colors never "squish"
            Rectangle {
                width: root.width
                height: root.height
                radius: 6
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                gradient: Gradient {
                    orientation: Gradient.Vertical

                    // 0% - Start Red
                    GradientStop {
                        position: 1.0
                        color: AppStyle.red_dim
                    }

                    // 40% - Fade to Orange
                    GradientStop {
                        position: 0.6
                        color: AppStyle.yellow_dim
                    }

                    // 100% - End Green
                    GradientStop {
                        position: 0.0
                        color: AppStyle.aqua_dim
                    }
                }
            }
        }

        // 4. Percentage Text Overlay
        Text {
            anchors.centerIn: parent
            text: Math.round(percentage) + "%"

            // Add a shadow so text is readable over any color
            color: "white"
            style: Text.Outline
            styleColor: "black"
            font.bold: true
            font.pixelSize: 12
        }
    }
}
