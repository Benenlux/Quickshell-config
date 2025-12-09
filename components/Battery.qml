import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "."

HoverPill {
    id: root
    property var battery: UPower.displayDevice
    property bool isPluggedIn: battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    property var profile: battery.PowerProfiles.profile
    property bool isExtended: false
    property string iconStep: {
        var steppedLevel = Math.floor(battery.percentage * 100 / 10) * 10;
        return steppedLevel.toString().padStart(3, "0");
    }
    //FIX: check for power profile support to prevent undefined behavior
    icon: {
        if (profile === 0)
            return Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : "") + "-profile-powersave");
        if (profile === 1)
            return Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : "") + "-profile-balanced");
        if (profile === 2)
            return Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : "") + "-profile-performance");
        else
            return Quickshell.iconPath("battery-" + (iconStep) + (isPluggedIn ? "-charging" : ""));
    }
    //FIX: check for power profile support to check if it can be changed
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (UPower.displayDevice.PowerProfiles.profile === 2)
                UPower.displayDevice.PowerProfiles.profile = 0;
            else
                UPower.displayDevice.PowerProfiles.profile = UPower.displayDevice.PowerProfiles.profile + 1;
        }
    }
    text: battery.percentage * 100 + "%"
}
