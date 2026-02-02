import QtQuick
import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

import "../.."

Item {
    id: root
    width: 18
    height: 18
    property string icon;
    property bool isActive: true;
    property bool isUrgent: false;

    IconImage {
        id: iconImage
        source: root.icon
        width: 18
        height: 18
        anchors.centerIn: parent
        visible: false
    }

   
    RectangularGlow {
        anchors.fill: iconImage
        glowRadius: 2
        spread: 0.2
        color: root.isUrgent ? "#FF5555" : (root.isActive ? "#88FFFFFF" : "transparent")
        cornerRadius: 18
    }
    
    
    IconImage {
        source: root.icon
        width: 18
        height: 18
        anchors.centerIn: parent
    }
}