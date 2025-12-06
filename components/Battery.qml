import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import ".."

Item {
    id: root
    property var battery: UPower.displayDevice
    property var percentage: Math.min(battery.percentage * 100)

    implicitWidth: 70
    implicitHeight: 10

    // Background
    Rectangle {
        implicitWidth: parent.implicitWidth - 10
        height: parent.implicitHeight
        color: "#3c3836"
        radius: 6

        Item {
            id: mask
            height: parent.width

            width: root.width * (Math.min(percentage, 100) / 100)

            clip: true

            Behavior on width {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }

            // The Full-Size Gradient Bar
            Rectangle {
                width: parent.width
                height: root.height
                radius: 6
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    // 0% - Start Red
                    GradientStop {
                        position: 1.0
                        color: AppStyle.green
                    }

                    // 50% - Fade to Orange
                    GradientStop {
                        position: 0.5
                        color: AppStyle.yellow_dim
                    }

                    // 100% - End Green
                    GradientStop {
                        position: 0.2
                        color: AppStyle.red
                    }
                }
            }
        }
    }
}
