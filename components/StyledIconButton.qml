import QtQuick
import Quickshell
import Quickshell.Widgets
import ".."

Item {
    id: root
    property color backgroundColor: AppStyle.bg1

    implicitWidth: buttonContent.implicitWidth
    implicitHeight: buttonContent.implicitWidth

    Rectangle {
        id: buttonContent
        implicitHeight: 40
        implicitWidth: 50
        anchors.centerIn: parent
        radius: 6
        color: backgroundColor
        IconImage {
            anchors.centerIn: parent
            width: 30
            height: 30
            source: Quickshell.iconPath('network-wireless-signal-none')
        }
    }
}
