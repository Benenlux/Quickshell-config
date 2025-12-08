import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import ".."
import "."

HoverPill {

    property var battery: UPower.displayDevice
    property bool isPluggedIn: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    property bool isExtended: false
    property string iconStep: {
        var steppedLevel = Math.floor(battery.percentage * 100 / 10) * 10;
        return steppedLevel.toString().padStart(3, "0");
    }
    icon: Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : ""))
    text: battery.percentage * 100 + "%"
}
