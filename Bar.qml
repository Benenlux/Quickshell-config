import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "./bar-widgets/"
import "./components/"

Scope {
    id: root
    property string time

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            height: 40

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30
            ClockWidget {
                anchors.centerIn: parent
            }

            Battery {}
        }
    }
}
