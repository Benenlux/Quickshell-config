import Quickshell
import QtQuick
import QtQuick.Layouts
import "../.."

PopupWindow {
    id: root

    property var windowId
    property Item anchorItem
    property var offsetX: 0
    property var offsetY: 0
    default property alias content: containerLayout.data

    implicitWidth: containerLayout.implicitWidth + 20
    implicitHeight: containerLayout.implicitHeight + 20

    color: "transparent"

    anchor.window: windowId

    onVisibleChanged: {
        if (visible && anchorItem && windowId) {
            var pos = anchorItem.mapToItem(windowId.contentItem, 0, 0);
            anchor.rect.x = pos.x + offsetX;
            anchor.rect.y = pos.y + offsetY;
            anchor.rect.implicitWidth = anchorItem.implicitWidth;
            anchor.rect.implicitHeight = anchorItem.implicitHeight;
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: {
            closeTimer.start();
        }
        onEntered: {
            closeTimer.stop();
        }
    }

    Timer {
        id: closeTimer
        interval: 500
        repeat: false
        onTriggered: root.visible = false
    }

    // Panel content
    Item {
        id: clipper
        anchors.fill: parent
        anchors.centerIn: parent

        clip: true

        implicitWidth: root.visible ? root.width : 0
        implicitHeight: root.visible ? root.height : 0

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuart
            }
        }

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuart
            }
        }

        Rectangle {
            anchors.centerIn: parent
            anchors.fill: parent

            color: AppStyle.bg_s
            radius: 6
            border.color: AppStyle.bg3
            Item {
                id: containerLayout
                anchors.centerIn: parent
                implicitWidth: children.length > 0 ? children[0].implicitWidth : 0
                implicitHeight: children.length > 0 ? children[0].implicitHeight : 0
                anchors.margins: 10
                width: implicitWidth
                height: implicitHeight
            }
        }
    }
}
