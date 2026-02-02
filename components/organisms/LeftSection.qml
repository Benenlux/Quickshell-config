import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

import "../atoms"
import "../molecules"

RowLayout{ 
    id: root
    spacing: 5

    Container{
        implicitHeight: 32
        Workspaces{

        }
    }
}