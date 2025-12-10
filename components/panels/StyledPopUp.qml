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

    width: containerLayout.implicitWidth + 10
    height: containerLayout.implicitHeight + 20

    color: "transparent"

    anchor.window: windowId

    onVisibleChanged: {
        if (visible && anchorItem && windowId) {
            var pos = anchorItem.mapToItem(windowId.contentItem, 0, 0);
            anchor.rect.x = pos.x + offsetX;
            anchor.rect.y = pos.y + offsetY;
            anchor.rect.width = anchorItem.width;
            anchor.rect.height = anchorItem.height;
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

        anchors.left: parent.left
        anchors.top: parent.top

        clip: true

        width: root.visible ? root.width : 0
        height: root.visible ? root.height : 0

        Behavior on width {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuart
            }
        }

        Behavior on height {
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutQuart
            }
        }

        Rectangle {

            anchors.fill: parent

            color: AppStyle.bg_s
            radius: 6
            border.color: AppStyle.bg3

            ColumnLayout {
                id: containerLayout
                spacing: 5
            }
        }
    }
}
