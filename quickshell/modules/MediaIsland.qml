import QtQuick
import QtQuick.Layouts

import "../services" as Services

// Rendered whenever a player has a loaded session (playing or paused) - stays
// up through a pause so the controls remain reachable, and only disappears
// once the player is fully stopped. Compact by design (just play/pause +
// track label inline) so it doesn't crowd out the focused-window island;
// prev/next/stop and the source picker live in the dropdown instead.
Rectangle {
    id: root

    readonly property bool active: Services.MprisSource.hasActiveMedia
    readonly property var activePlayer: Services.MprisSource.activePlayer

    visible: active
    implicitWidth: active ? (content.implicitWidth + 16) : 0
    implicitHeight: active ? (content.implicitHeight + 8) : 0

    color: "#99000000"
    radius: 8

    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: root.activePlayer && root.activePlayer.isPlaying ? "⏸" : "⏵"
            color: "white"
            MouseArea {
                anchors.fill: parent
                onClicked: root.activePlayer.togglePlaying()
            }
        }

        Text {
            id: label
            color: "white"
            width: Math.min(implicitWidth, 220)
            elide: Text.ElideRight

            text: {
                const p = root.activePlayer;
                if (!p)
                    return "";
                if (p.trackArtist && p.trackTitle)
                    return p.trackArtist + " - " + p.trackTitle;
                if (p.trackTitle)
                    return p.trackTitle;
                return p.identity;
            }

            MouseArea {
                anchors.fill: parent
                onClicked: menu.toggle()
            }
        }

        Text {
            text: "▾"
            color: "white"
            MouseArea {
                anchors.fill: parent
                onClicked: menu.toggle()
            }
        }

        DropdownPopup {
            id: menu
            anchorItem: label

            RowLayout {
                spacing: 10

                Text {
                    text: "⏮"
                    color: "white"
                    visible: root.activePlayer && root.activePlayer.canGoPrevious
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.activePlayer.previous()
                    }
                }

                Text {
                    text: root.activePlayer && root.activePlayer.isPlaying ? "⏸" : "⏵"
                    color: "white"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.activePlayer.togglePlaying()
                    }
                }

                Text {
                    text: "⏭"
                    color: "white"
                    visible: root.activePlayer && root.activePlayer.canGoNext
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.activePlayer.next()
                    }
                }

                Text {
                    text: "⏹"
                    color: "white"
                    visible: root.activePlayer && root.activePlayer.canControl
                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.activePlayer.stop()
                    }
                }
            }

            Repeater {
                model: Services.MprisSource.sessionPlayers

                Text {
                    required property var modelData

                    width: parent.width
                    color: modelData.dbusName === (root.activePlayer ? root.activePlayer.dbusName : "") ? "#88ff88" : "white"
                    text: modelData.identity

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Services.MprisSource.setManual(modelData.dbusName);
                            menu.close();
                        }
                    }
                }
            }

            Text {
                width: parent.width
                color: "#aaaaaa"
                text: "Auto"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Services.MprisSource.clearManual();
                        menu.close();
                    }
                }
            }
        }
    }
}
