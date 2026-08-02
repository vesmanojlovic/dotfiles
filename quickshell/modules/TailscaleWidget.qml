import QtQuick
import Quickshell.Io

Item {
    id: root

    readonly property string exitNodeName: "sabirni-centar"

    property bool running: false
    property bool exitNodeActive: false

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Text {
        id: label
        color: root.running ? "#88ff88" : "white"
        text: "TS" + (root.exitNodeActive ? " (exit)" : "")
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            statusProcess.running = true;
            menu.toggle();
        }
    }

    DropdownPopup {
        id: menu
        anchorItem: label

        Text {
            width: parent.width
            color: root.running ? "#88ff88" : "white"
            text: root.running ? "Disconnect" : "Connect"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    toggleProcess.exec(["tailscale", root.running ? "down" : "up"]);
                    menu.close();
                }
            }
        }

        Text {
            width: parent.width
            color: root.exitNodeActive ? "#88ff88" : "white"
            text: "Exit node (" + root.exitNodeName + "): " + (root.exitNodeActive ? "on" : "off")
            enabled: root.running
            opacity: root.running ? 1.0 : 0.4

            MouseArea {
                anchors.fill: parent
                enabled: root.running
                onClicked: {
                    exitNodeProcess.exec(["tailscale", "set",
                        root.exitNodeActive ? "--exit-node=" : ("--exit-node=" + root.exitNodeName)]);
                    menu.close();
                }
            }
        }
    }

    Process {
        id: statusProcess
        command: ["tailscale", "status", "--json"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: {
                try {
                    const data = JSON.parse(text);
                    root.running = data.BackendState === "Running";
                    root.exitNodeActive = !!data.ExitNodeStatus;
                } catch (e) {
                    // tailscaled not reachable; leave last-known state
                }
            }
        }
    }

    Process {
        id: toggleProcess
        onExited: refreshTimer.triggered()
    }

    Process {
        id: exitNodeProcess
        onExited: refreshTimer.triggered()
    }

    Timer {
        id: refreshTimer
        interval: 3000
        running: true
        repeat: true
        onTriggered: statusProcess.running = true
    }

    Component.onCompleted: statusProcess.running = true
}
