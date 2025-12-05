import QtQuick
import QtQuick.Layouts
import "../components/"
import ".."

RowLayout {
    spacing: 2
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Card {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Label {
                text: Time.time
            }
        }
    }
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Card {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Label {
                text: Time.date
            }
        }
    }
}
