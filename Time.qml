pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// your singletons should always have Singleton as the type
Singleton {
  id: root
  property string time
  property string date

  Process {
    id: dateProc
    command: ["date", "+%d %B"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.date = this.text
    }
  }

  Process {
    id: timeProc
    command: ["date", "+%T"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: timeProc.running = true
  }
}
