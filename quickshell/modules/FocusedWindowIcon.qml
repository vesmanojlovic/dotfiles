import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

// Shows the currently globally-focused window's app icon + live title
// (e.g. a browser's title reflects its active tab). Identical on both bars,
// since Hyprland only ever has one focused window compositor-wide.
RowLayout {
    id: root

    spacing: 6

    // Externally imposed cap (set by Bar.qml based on actual space left
    // between the workspace and utility islands) so the title truncates
    // with an ellipsis instead of overlapping neighboring islands.
    property real maxTextWidth: 500

    readonly property var toplevel: Hyprland.activeToplevel
    readonly property string appId: toplevel && toplevel.wayland ? toplevel.wayland.appId : ""
    readonly property string windowTitle: toplevel ? toplevel.title : ""

    readonly property var desktopEntry: {
        // Read .values so this binding depends on the (async) desktop entry
        // scan and re-evaluates once it completes, instead of caching a
        // premature null from before the scan finished.
        DesktopEntries.applications.values;

        if (!appId)
            return null;
        return DesktopEntries.heuristicLookup(appId) ?? DesktopEntries.byId(appId);
    }

    IconImage {
        implicitSize: 20
        source: Quickshell.iconPath(root.desktopEntry ? root.desktopEntry.icon : "", "image-missing")
    }

    Text {
        Layout.maximumWidth: root.maxTextWidth
        elide: Text.ElideRight
        color: "white"
        text: root.windowTitle
    }
}
