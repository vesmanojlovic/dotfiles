pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// Tracks which MPRIS player the media island/hardware keys should control.
// Default: whichever playing player most recently started/resumed playing.
// A manual pick (from the media island's source dropdown) overrides that
// until cleared.
Item {
    id: root

    property string manualDbusName: ""
    property string lastActiveDbusName: ""

    // Playing OR paused - i.e. has a loaded session, not necessarily
    // actively making sound right now. The island should stay visible
    // through a pause so you can still reach the controls to resume;
    // it should only disappear once a player is fully Stopped/gone.
    property var sessionPlayers: {
        const list = [];
        for (const p of Mpris.players.values) {
            if (p.playbackState !== MprisPlaybackState.Stopped)
                list.push(p);
        }
        return list;
    }

    readonly property bool hasActiveMedia: sessionPlayers.length > 0

    readonly property var activePlayer: {
        if (!hasActiveMedia)
            return null;

        if (manualDbusName) {
            for (const p of sessionPlayers) {
                if (p.dbusName === manualDbusName)
                    return p;
            }
            // manual pick has no active session anymore, fall through to auto
        }

        for (const p of sessionPlayers) {
            if (p.dbusName === lastActiveDbusName)
                return p;
        }

        return sessionPlayers[0];
    }

    function setManual(dbusName) {
        manualDbusName = dbusName;
    }

    function clearManual() {
        manualDbusName = "";
    }

    Timer {
        // isPlaying transitions on an existing player don't emit Mpris.playersChanged,
        // so poll lightly to catch play/pause/track-change events and re-stamp
        // "most recently active" for the auto-selection logic above.
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            for (const p of Mpris.players.values) {
                if (p.isPlaying)
                    root.lastActiveDbusName = p.dbusName;
            }
        }
    }
}
