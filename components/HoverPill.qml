import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

Item {
    id: root

    property string defaultText: ""
    property string text: ""
    property string icon: ""
    property int iconWidth: 22
    property int iconHeight: 22

    property color backgroundColor: AppStyle.bg3
    property color textColor: AppStyle.fg1

    // --- Internal Logic ---
    property bool isExtended: false

    implicitWidth: isExtended ? row.implicitWidth + 16 : row.implicitWidth + 10
    implicitHeight: row.implicitHeight

    clip: true

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutQuart
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        repeat: false
        onTriggered: root.isExtended = false
    }

    // --- Visuals ---
    Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: 6
        color: root.backgroundColor

        // Use isExtended so the background stays visible during the 1s delay
        opacity: mouseArea.containsMouse ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 2

        IconImage {
            Layout.alignment: Qt.AlignVCenter
            width: root.iconWidth
            height: root.iconHeight
            source: root.icon
        }

        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            color: root.textColor

            // Only render text when extended
            text: root.isExtended ? root.text : root.defaultText
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        hoverEnabled: true
        onEntered: {
            hideTimer.stop();
            root.isExtended = true;
        }
        onExited: {
            hideTimer.start();
        }
    }
}
