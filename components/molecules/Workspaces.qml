import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets

import "../atoms"

Item {
    id: root
    readonly property var monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    implicitHeight: 25
    implicitWidth: workspaceLayout.implicitWidth + 20
    RowLayout {
        id: workspaceLayout
        anchors.centerIn: parent
        
        spacing: 15
        Repeater {
            model: Hyprland.workspaces

        
                WorkspaceButton {
                    workspace: modelData
                    hasActive: monitor?.activeWorkspace == modelData
                }
        }
    }
}