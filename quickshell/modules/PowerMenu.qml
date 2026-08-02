import QtQuick
import QtQuick.Layouts
import Quickshell

import "../services" as Services

PanelWindow {
    id: root

    property var modelData
    screen: modelData

    visible: Services.PowerMenuState.open
    focusable: true

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    color: "#88000000"

    MouseArea {
        // click-outside-to-close
        anchors.fill: parent
        onClicked: Services.PowerMenuState.close()
    }

    Rectangle {
        anchors.centerIn: parent
        width: 360
        height: 80
        color: "#222222"
        border.color: "#555555"

        RowLayout {
            anchors.centerIn: parent
            spacing: 16

            Text {
                color: "white"
                text: "Lock"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Services.PowerMenuState.lock()
                }
            }

            Text {
                color: "white"
                text: "Logout"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Services.PowerMenuState.logout()
                }
            }

            Text {
                color: "white"
                text: "Suspend"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Services.PowerMenuState.suspend()
                }
            }

            Text {
                color: Services.PowerMenuState.armed === "reboot" ? "#ff8888" : "white"
                text: Services.PowerMenuState.armed === "reboot" ? "Confirm?" : "Reboot"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Services.PowerMenuState.reboot()
                }
            }

            Text {
                color: Services.PowerMenuState.armed === "shutdown" ? "#ff8888" : "white"
                text: Services.PowerMenuState.armed === "shutdown" ? "Confirm?" : "Shutdown"
                MouseArea {
                    anchors.fill: parent
                    onClicked: Services.PowerMenuState.shutdown()
                }
            }
        }
    }
}
