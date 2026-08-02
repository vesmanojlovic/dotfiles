pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    id: root

    property bool open: false

    // "" | "reboot" | "shutdown" - set on first click of a destructive
    // action, cleared by confirmArmedTimer if not confirmed within 3s.
    property string armed: ""

    function toggle() {
        root.open = !root.open;
        root.armed = "";
    }

    function close() {
        root.open = false;
        root.armed = "";
    }

    function lock() {
        Quickshell.execDetached(["hyprlock"]);
        close();
    }

    function logout() {
        Hyprland.dispatch("exit");
        close();
    }

    function suspend() {
        Quickshell.execDetached(["systemctl", "suspend"]);
        close();
    }

    function reboot() {
        if (root.armed === "reboot") {
            Quickshell.execDetached(["systemctl", "reboot"]);
            close();
        } else {
            root.armed = "reboot";
            confirmArmedTimer.restart();
        }
    }

    function shutdown() {
        if (root.armed === "shutdown") {
            Quickshell.execDetached(["systemctl", "poweroff"]);
            close();
        } else {
            root.armed = "shutdown";
            confirmArmedTimer.restart();
        }
    }

    Timer {
        id: confirmArmedTimer
        interval: 3000
        onTriggered: root.armed = ""
    }
}
