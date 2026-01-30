import QtQuick
import Quickshell
import QtQuick.Layouts
import "../atoms"
import "../.."

Rectangle {
    id: root
    color: AppStyle.bg_h 
    radius: 7

    implicitWidth: mainLayout.implicitWidth + 10
    implicitHeight: mainLayout.implicitHeight + 10
    default property alias content: mainLayout.data

    RowLayout {
        id: mainLayout
        anchors.centerIn: parent
        spacing: 5
    }
}
