import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    id: root

    property var screen

    readonly property var monitor: screen ? Hyprland.monitorFor(screen) : null

    readonly property var shownWorkspaces: {
        if (!monitor)
            return [];

        return Hyprland.workspaces.values.filter(w => {
            return w.monitor === monitor && (w.active || w.toplevels.values.length > 0);
        }).sort((a, b) => a.id - b.id);
    }

    spacing: 4

    Repeater {
        model: root.shownWorkspaces

        Rectangle {
            required property var modelData

            implicitWidth: 24
            implicitHeight: 24
            radius: 4
            color: modelData.focused ? "#88ffffff" : (modelData.active ? "#44ffffff" : "#22ffffff")

            Text {
                anchors.centerIn: parent
                text: modelData.name
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: modelData.activate()
            }
        }
    }
}
