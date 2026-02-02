import QtQuick
import Quickshell
import "../../Utils/"

HoverPill {
    id: wifiPill
    text: WifiGetter.ssid
    property var s: WifiGetter.strength
    icon: {
        if (s > 80)
            return Quickshell.iconPath("network-wireless-signal-excellent");
        if (s > 60)
            return Quickshell.iconPath("network-wireless-signal-good");
        if (s > 40)
            return Quickshell.iconPath("network-wireless-signal-ok");
        if (s > 20)
            return Quickshell.iconPath("network-wireless-signal-low");
        if (s > 0)
            return Quickshell.iconPath("network-wireless-signal-none");
        if (s == 0) {
            return Quickshell.iconPath("network-wireless-offline");
        }
    }
}
