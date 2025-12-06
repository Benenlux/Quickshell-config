import QtQuick
import ".."

Rectangle {
    id: root
    color: mouseArea.containsMouse ? AppStyle.bg3 : AppStyle.bg1
    radius: 7

    implicitWidth: layout.implicitWidth + 10
    implicitHeight: 25

    // 2. Redirect children to the Column
    default property alias content: layout.data

    Behavior on color {
        ColorAnimation {
            duration: 150
        } // 150ms fade duration
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
    Column {
        id: layout
        anchors.centerIn: parent
    }
}
