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
    property bool isHovered: false;
    
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

    function getIcon(className) {
        if (!className) return Quickshell.iconPath("application-x-executable");

        // Normalize to lowercase for consistent matching
        const lowerName = className.toLowerCase();

        // Map: "Raw Class Name" : "Desired Icon Name"
        const iconMap = {
            "code": "visual-studio-code",
            "code-url-handler": "visual-studio-code",
            "jetbrains-idea": "intellij-idea-ultimate-edition",
            "console": "Alacritty",     
            "kitty": "Alacritty",
            "alacritty": "Alacritty",
            "thunar": "system-file-manager",
            "xdg-desktop-portal-gtk": "system-file-manager",
        };

        // Check map first, otherwise use the original name
        const iconName = iconMap[lowerName] || lowerName;

        // Resolve the path
        return Quickshell.iconPath(iconName);
    }
    Rectangle {
        id: workspaceIndicator
    
        width: toplevelLayout.implicitWidth + 15;
        height: 25
        radius: 40
        color: {
            if (root.isHovered) {
                return AppStyle.bg2;
            }
            return root.hasActive ? AppStyle.bg_s : 'transparent'
        }


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
                    icon: getIcon(modelData.initialClass || modelData.class)
                    isActive: root.isWindowActive(modelData.address)
                   
                }
                
            }
        }

    }
    MouseArea {
        id: mouseArea
        anchors.fill: workspaceIndicator
        hoverEnabled: true
        onEntered: {
            root.isHovered = true;
        }
        onExited: {
            root.isHovered = false;
        }
        onClicked: {
            Hyprland.dispatch("workspace " + root.workspace.id);
        }
    }
}