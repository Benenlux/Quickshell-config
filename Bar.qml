import Quickshell
import Quickshell.Io
import QtQuick

import "./bar-widgets/"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 40
            ConnectivityContainer {}
            MainContainer {}
        }
    }
}
