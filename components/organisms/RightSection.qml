import QtQuick
import Quickshell
import QtQuick.Layouts

import "../atoms"
import "../molecules"

// Make RowLayout the root. It automatically calculates implicit size.
RowLayout {
    spacing: 10

    Container {
        id: container1
        Wifi {
        }

        Bluetooth {
        }

        Battery {
            Layout.alignment: Qt.AlignVCenter
        }
    }
}


