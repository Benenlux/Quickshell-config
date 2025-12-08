import QtQuick

import QtQuick.Controls
import Quickshell
import Quickshell.Bluetooth // The module name is correct now
import "."
import Quickshell.Widgets

HoverPill {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    property bool isOn: Bluetooth.defaultAdapter.enabled
    icon: Quickshell.iconPath(isOn ? "bluetooth-active" : "bluetooth-disabled")
}
