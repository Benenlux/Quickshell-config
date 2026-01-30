import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "."

HoverPill{
    id: root
    property var battery: UPower.displayDevice
    property var profile: battery.PowerProfiles.profile
    icon: {
        if (profile === 0)
            return Quickshell.iconPath("battery-profile-powersave");
        if (profile === 1)
            return Quickshell.iconPath("battery-profile-balanced");
        if (profile === 2)
            return Quickshell.iconPath("battery-profile-performance");
        else
            return Quickshell.iconPath("power-profile-unknown");
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (UPower.displayDevice.PowerProfiles.profile === 2)
                UPower.displayDevice.PowerProfiles.profile = 0;
            else
                UPower.displayDevice.PowerProfiles.profile = UPower.displayDevice.PowerProfiles.profile + 1;
        }
    }
}