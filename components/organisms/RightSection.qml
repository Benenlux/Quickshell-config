import QtQuick
import Quickshell
import QtQuick.Layouts

import "../atoms"
import "../molecules"

// Make RowLayout the root. It automatically calculates implicit size.
RowLayout {
    spacing: 5

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


