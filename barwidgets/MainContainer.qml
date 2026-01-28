import QtQuick
import Quickshell
import QtQuick.Layouts
import "../components/"
import ".."
import "../components/panels/"

Item {
    id: panelContent
    anchors.fill: parent
    anchors.rightMargin: 6
    anchors.leftMargin: 6
    property var panelWindow
    Rectangle {
        id: connectivity_container
        color: AppStyle.bg1
        implicitWidth: mainLayout.implicitWidth + 10
        implicitHeight: mainLayout.implicitHeight + 10
        radius: 7
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        RowLayout {
            id: mainLayout
            anchors.centerIn: parent
            spacing: 5
            LogoButton {
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        popUp.visible = !popUp.visible;
                        popUp.width = 50;
                    }
                }
            }
        }
    }
    StyledPopUp {
        id: popUp
        windowId: panelContent.panelWindow
        anchorItem: connectivity_container
        offsetY: 35
        GridLayout {
            rowSpacing: 10
            columnSpacing: 10
            columns: 4

            Rectangle {
                Layout.columnSpan: 2
                Layout.rowSpan: 2

                Layout.preferredWidth: 200
                Layout.preferredHeight: 100
                Layout.fillWidth: true
                Layout.fillHeight: true

                color: "lightgrey"
                border.color: "black"

                Text {
                    anchors.centerIn: parent
                    text: "100x100"
                }
            }

            StyledIconButton {
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                iconSource: 'system-shutdown'
            }

            // Item 4 (Top row, col 4)
            StyledIconButton {
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                iconSource: 'system-reboot'
            }

            // Item 5 (Row 2, col 3 - since the big rect takes Row 2, Cols 1&2)
            StyledIconButton {
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                iconSource: 'system-suspend'
            }
            StyledIconButton {
                Layout.preferredWidth: 50
                Layout.preferredHeight: 50
                iconSource: 'lock'
            }
        }
    }
}
