import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "./bar-widgets/"
import "./components/"
import "."

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            height: 40

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            ClockWidget {
                anchors.centerIn: parent
            }
            Rectangle {
                color: AppStyle.gray_dim
                implicitWidth: bat.implicitWidth + 10
                implicitHeight: 25
                radius: 7
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                Battery {
                    id: bat
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
