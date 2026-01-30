import QtQuick

import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import "."
import Quickshell.Widgets


HoverPill {
    id: root

    PwObjectTracker {
		objects: [ Pipewire.defaultAudioSource ]
	}

    property var node: Pipewire.defaultAudioSource
    property bool isOn: Pipewire.defaultAudioSource.audio.muted === false
    icon: {
        if (root.node.audio.muted){
            return Quickshell.iconPath("microphone-sensitivity-muted");
        } else if (node.audio.volume >= 0.67){
            return Quickshell.iconPath("microphone-sensitivity-high");
        } else if (node.audio.volume >= 0.34){
            return Quickshell.iconPath("microphone-sensitivity-medium");
        } else {
            return Quickshell.iconPath("microphone-sensitivity-low");
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.node.audio.muted = root.isOn;
        }
    }
    
    
    text: {
        if (isOn){
            return Math.round(root.node.audio.volume * 100) + "%";
        }
        return "Muted";
    }
}