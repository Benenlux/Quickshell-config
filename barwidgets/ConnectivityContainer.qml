import QtQuick
import Quickshell
import QtQuick.Layouts
import "../components/"
import ".."

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
            Bluetooth {}
            Battery {}
            Clock {}
        }
    }
}
