import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets
// import Utils
import "./"
import "../.."
import "../../Utils"

Item {
    implicitWidth: toplevelLayout.implicitWidth 
    implicitHeight: toplevelLayout.implicitHeight
    id: root
    property bool hasActive: true;
    property HyprlandWorkspace workspace: null;
    
    readonly property var toplevels: HyprlandData.hyprlandClientsForWorkspace(root.workspace.id)
    //TODO: Fuzzy find the icon for case sensitivity and different namings
    
    function isWindowActive(clientAddress) {
        if (!Hyprland.activeWindow) return false;
        
        let activeAddr = Hyprland.activeWindow.address;
        if (!activeAddr.startsWith("0x")) activeAddr = "0x" + activeAddr;
        
        let clientAddr = clientAddress;
        if (!clientAddr.startsWith("0x")) clientAddr = "0x" + clientAddr;

        return activeAddr === clientAddr;
    }
    Rectangle {
        id: workspaceIndicator
    
        width: root.hasActive ? toplevelLayout.implicitWidth + 15 : 25
        height: 25
        radius: 40
        color: root.hasActive ? AppStyle.bg_s : 'transparent'

        anchors.centerIn: parent

        Behavior on width { NumberAnimation { duration: 250; easing.type: Easing.OutQuad } }
        Behavior on color { ColorAnimation { duration: 200 } }

        RowLayout {
            spacing: 5
            id: toplevelLayout
            anchors.centerIn: parent
            Repeater {
                id: toplevelRepeater
                model: root.toplevels
                Layout.alignment: Qt.AlignVCenter
                TopLevelButton {
                    icon: Quickshell.iconPath(modelData.initialClass || modelData.class)
                    isActive: root.isWindowActive(modelData.address)
                   
                }
                
            }
        }
        

    }
}