import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import QtQuick

import "./components/organisms"
import "./components/atoms"
import "./components/molecules"

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
            Item {
                id: panelContent
                anchors.fill: parent
                anchors.rightMargin: 6
                anchors.leftMargin: 6
                RightSection{
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
