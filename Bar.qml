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

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 50
            Item {
                id: panelContent
                anchors.fill: parent
                anchors.rightMargin: 6
                anchors.leftMargin: 6

                Rectangle {
                    id: connectivity_container
                    color: AppStyle.bg1
                    implicitWidth: mainLayout.implicitWidth + 10
                    implicitHeight: mainLayout.implicitHeight + 10
                    radius: 7
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    RowLayout {
                        id: mainLayout
                        anchors.centerIn: parent
                        spacing: 5
                        Wifi {}
                        Battery {
                            Layout.alignment: Qt.AlignVCenter
                        }
                        Clock {}
                    }
                }
            }
        }
    }
}
