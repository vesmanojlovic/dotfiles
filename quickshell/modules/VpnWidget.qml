import QtQuick
import QtQuick.Layouts
import Quickshell.Io

// AirVPN: dropdown of "AirVPN-<Location>" NetworkManager connections + toggle.
// No kill switch (avoids conflicting with the Tailscale exit-node widget).
Item {
    id: root

    property var availableConnections: []
    property string activeConnection: ""

    implicitWidth: label.implicitWidth + 8
    implicitHeight: label.implicitHeight

    Text {
        id: label
        anchors.fill: parent
        color: root.activeConnection ? "#88ff88" : "white"
        text: "VPN" + (root.activeConnection ? (": " + root.activeConnection.replace("AirVPN-", "")) : "")
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            listProcess.running = true;
            menu.toggle();
        }
    }

    DropdownPopup {
        id: menu
        anchorItem: label

        Repeater {
            model: root.availableConnections

            Text {
                required property string modelData

                width: parent.width
                color: modelData === root.activeConnection ? "#88ff88" : "white"
                text: modelData.replace("AirVPN-", "")

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (modelData === root.activeConnection) {
                            downProcess.exec(["nmcli", "connection", "down", modelData]);
                        } else {
                            upProcess.exec(["bash", "-c",
                                "nmcli -t -f NAME,TYPE connection show --active | grep ':wireguard$' | grep '^AirVPN-' | cut -d: -f1 | xargs -r -I{} nmcli connection down '{}'; nmcli connection up '" + modelData + "'"
                            ]);
                        }
                        menu.close();
                    }
                }
            }
        }

        Text {
            width: parent.width
            visible: root.availableConnections.length === 0
            color: "#aaaaaa"
            text: "(no AirVPN connections found)"
        }
    }

    Process {
        id: listProcess
        command: ["bash", "-c", "nmcli -t -f NAME,TYPE connection show | grep ':wireguard$' | grep '^AirVPN-' | cut -d: -f1"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: {
                root.availableConnections = text.trim().split("\n").filter(s => s.length > 0);
            }
        }
    }

    Process {
        id: activeProcess
        command: ["bash", "-c", "nmcli -t -f NAME,TYPE connection show --active | grep ':wireguard$' | grep '^AirVPN-' | cut -d: -f1"]
        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: {
                const lines = text.trim().split("\n").filter(s => s.length > 0);
                root.activeConnection = lines.length > 0 ? lines[0] : "";
            }
        }
    }

    Process {
        id: downProcess
    }

    Process {
        id: upProcess
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            activeProcess.running = true;
        }
    }

    Component.onCompleted: {
        listProcess.running = true;
        activeProcess.running = true;
    }
}
