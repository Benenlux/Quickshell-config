import QtQuick

import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth
import "."
import Quickshell.Widgets

HoverPill {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    property bool isOn: Bluetooth.defaultAdapter.enabled
    icon: Quickshell.iconPath(isOn ? "bluetooth" : "bluetooth-disabled")
}
