import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import ".."
import "."
import Quickshell.Widgets

Item {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
    property var battery: UPower.displayDevice
    property bool isPluggedIn: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    property string iconStep: {
        var steppedLevel = Math.floor(battery.percentage * 100 / 10) * 10;
        return steppedLevel.toString().padStart(3, "0");
    }

    RowLayout {
        id: row
        anchors.fill: parent
        Label {
            Layout.alignment: Qt.AlignVCenter
            Layout.fillHeight: true
            text: battery.percentage * 100 + "%"
            verticalAlignment: Text.AlignVCenter
        }
        IconImage {
            Layout.alignment: Qt.AlignVCenter
            width: 25
            height: 25
            source: Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : ""))
        }
    }
}
