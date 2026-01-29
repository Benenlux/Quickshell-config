pragma Singleton
import QtQuick 2.15

QtObject {
    // --- Backgrounds ---
    // Mapped from Darkest (Crust) to Lighter surfaces (Surface/Overlay)
    readonly property color bg_h: "#181926" // Crust (Hard contrast)
    readonly property color bg: "#24273a"   // Base (Standard bg)
    readonly property color bg_s: "#363a4f" // Surface0
    readonly property color bg1: "#494d64"  // Surface1
    readonly property color bg2: "#5b6078"  // Surface2
    readonly property color bg3: "#6e738d"  // Overlay0
    readonly property color bg4: "#8087a2"  // Overlay1

    // --- Foreground / Text ---
    // Mapped from Brightest (Text) to Dimmer (Overlay)
    readonly property color fg: "#cad3f5"   // Text
    readonly property color fg1: "#b8c0e0"  // Subtext1
    readonly property color fg2: "#a5adcb"  // Subtext0
    readonly property color fg3: "#939ab7"  // Overlay2
    readonly property color fg4: "#8087a2"  // Overlay1

    // --- Bright Colors ---
    readonly property color red: "#ed8796"
    readonly property color green: "#a6da95"
    readonly property color yellow: "#eed49f"
    readonly property color blue: "#8aadf4"
    readonly property color purple: "#c6a0f6" // Mauve
    readonly property color aqua: "#8bd5ca"   // Teal
    readonly property color gray: "#939ab7"   // Overlay2
    readonly property color orange: "#f5a97f" // Peach

    // --- Dim Colors ---
    // Catppuccin is flatter than Gruvbox, so "Dim" colors are mapped 
    // to alternate accents (e.g. Maroon for Red) or slightly darker tones.
    readonly property color red_dim: "#ee99a0"    // Maroon
    readonly property color green_dim: "#94e2d5"  // Teal (often acts as alt green)
    readonly property color yellow_dim: "#e5c890" // Slightly darker yellow tone
    readonly property color blue_dim: "#7dc4e4"   // Sapphire
    readonly property color purple_dim: "#f5bde6" // Pink
    readonly property color aqua_dim: "#81c8be"   // Teal dimmed
    readonly property color gray_dim: "#6e738d"   // Overlay0
    readonly property color orange_dim: "#ef9f76" // Peach darker
}
