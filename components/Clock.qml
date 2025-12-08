import QtQuick
import Quickshell
import QtQuick.Layouts
import ".."

HoverPill {
    id: clockWidget

    SystemClock {
        id: time
        precision: clockWidget.isExtended ? SystemClock.Seconds : SystemClock.Minutes
    }

    defaultText: Qt.formatDateTime(time.date, "hh:mm")
    text: Qt.formatDateTime(time.date, "hh:mm:ss - dd MMM")
    icon: Quickshell.iconPath("clock")
}
