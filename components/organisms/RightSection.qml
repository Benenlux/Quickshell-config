import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

import "../atoms"
import "../molecules"

// Make RowLayout the root. It automatically calculates implicit size.
RowLayout {
    id: root
    spacing: 5

    property var monitorHandle: null 
    

    Container{
        id: container2
        implicitHeight: 32
        Audio {
            Layout.alignment: Qt.AlignVCenter
        }
        Microphone {
            Layout.alignment: Qt.AlignVCenter
        }
        
    }
    Container {
        id: container1
        Wifi {
        }

        Bluetooth {
        }

        
    }
    Container {
    id: container3
    HoverPill{
        property var brightness:  Math.round(root.monitorHandle.brightness * 100)
        text: root.monitorHandle ? Math.round(root.monitorHandle.brightness * 100) + "%" : "--"
        icon: {
            if (brightness < 20){
                return Quickshell.iconPath("system-brightness-20")
            } else if (brightness < 40){
                return Quickshell.iconPath("system-brightness-40")
            } else if (brightness < 60){
                return Quickshell.iconPath("system-brightness-60")
            } else if (brightness < 80){
                return Quickshell.iconPath("system-brightness-80")
            } else {
                return Quickshell.iconPath("system-brightness-100")
            }
        }
    }
    Battery {
        Layout.alignment: Qt.AlignVCenter
    }
    PowerProfiles {
        Layout.alignment: Qt.AlignVCenter
    }
    }
    Container{
        implicitHeight: 32
    Clock{}

    }
}


