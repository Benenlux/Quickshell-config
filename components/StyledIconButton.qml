import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

Item {
    id: root
    property color backgroundColor: AppStyle.bg1
    property var iconSource
    implicitWidth: buttonContent.implicitWidth
    implicitHeight: buttonContent.implicitWidth

    Rectangle {
        id: buttonContent
        anchors.fill: parent
        radius: 6
        color: root.backgroundColor

        IconImage {
            anchors.centerIn: parent
            width: root.width * 0.8
            height: root.width * 0.8

            source: Quickshell.iconPath(root.iconSource)
        }
    }
}
