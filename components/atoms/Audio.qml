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
    icon: Quickshell.iconPath(isOn ? "audio-on" : "audio-volume-muted")
    
    
    text: {
        const vol = root.node?.audio?.volume;
        return (vol !== undefined) ? Math.round(vol * 100) + "%" : "0%";
    }
}