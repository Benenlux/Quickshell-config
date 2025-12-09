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
        Text {
            anchors.centerIn: parent
            text: "I grew!"
            color: "white"
        }
    }
}
