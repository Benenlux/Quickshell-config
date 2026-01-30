import QtQuick

import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import "."
import Quickshell.Widgets


HoverPill {
    id: root

    PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

    property var node: Pipewire.defaultAudioSink
    property bool isOn: Pipewire.defaultAudioSink.audio.muted === false
    property int volume: node.audio.volume * 100
    icon: {
        if (!isOn){
            return Quickshell.iconPath("audio-volume-muted");
        } else if (volume >= 67){
            return Quickshell.iconPath("audio-volume-high");
        } else if (volume >= 34){
            return Quickshell.iconPath("audio-volume-medium");
        } else {
            return Quickshell.iconPath("audio-volume-low");
        }
    }
    
    
    text: {
        const vol = root.node?.audio?.volume;
        return (vol !== undefined) ? Math.round(vol * 100) + "%" : "0%";
    }
}