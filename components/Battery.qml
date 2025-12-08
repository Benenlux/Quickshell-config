import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import ".."
import "."
import Quickshell.Widgets

Item {
    id: root
    implicitWidth: mouseArea.containsMouse ? row.implicitWidth + 6 : row.implicitWidth
    implicitHeight: row.implicitHeight
    property var battery: UPower.displayDevice
    property bool isPluggedIn: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    property string iconStep: {
        var steppedLevel = Math.floor(battery.percentage * 100 / 10) * 10;
        return steppedLevel.toString().padStart(3, "0");
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: 6
        color: AppStyle.bg3

        opacity: mouseArea.containsMouse ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            } // 200ms feels snappier for hover
        }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 2
        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.fillHeight: true
            text: battery.percentage * 100 + "%"
            verticalAlignment: Text.AlignVCenter
        }
        IconImage {
            Layout.alignment: Qt.AlignVCenter
            width: 22
            height: 22
            source: Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : ""))
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: root
        hoverEnabled: true
    }
}
