import QtQuick

Text {
    id: root

    color: "white"
    text: Qt.formatDateTime(now, "HH:mm   dd MMMM yyyy")

    property var now: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }
}
