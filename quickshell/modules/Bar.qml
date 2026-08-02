import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
    id: bar

    property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 32
    color: "transparent"

    // Reserve space for the workspace island's theoretical worst case (all
    // 10 workspaces, matching the $mainMod+1..0 keybind range) so the
    // middle island's start position is fixed and never shifts around as
    // the actual (usually much smaller) workspace count changes.
    readonly property int maxWorkspacePills: 10
    readonly property real workspacePillWidth: 24
    readonly property real workspacePillSpacing: 4
    readonly property real maxWorkspacesRowWidth: maxWorkspacePills * workspacePillWidth
        + (maxWorkspacePills - 1) * workspacePillSpacing
    readonly property real islandPadding: 16
    readonly property real leftIslandMargin: 4
    readonly property real centerGap: 8
    readonly property real centerStartX: leftIslandMargin + maxWorkspacesRowWidth + islandPadding + centerGap

    Island {
        id: leftIsland
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: 4
        }

        Workspaces {
            screen: bar.screen
        }
    }

    RowLayout {
        id: rightGroup
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: 4
        }
        spacing: 8

        MediaIsland {}

        Island {
            Tray {}
            VpnWidget {}
            TailscaleWidget {}
            ClockWidget {}
            PowerMenuButton {}
        }
    }

    // Left edge fixed at centerStartX (independent of the workspace
    // island's actual current width) and right-bounded by rightGroup so it
    // still can't overlap that side - its own Island shrinks/truncates
    // (ellipsis) to fit whatever space is actually left, which varies as
    // the media island appears/disappears.
    Item {
        id: centerContainer
        anchors {
            left: parent.left
            right: rightGroup.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: bar.centerStartX
            rightMargin: 8
        }

        Island {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            width: Math.min(implicitWidth, centerContainer.width)
            clip: true

            FocusedWindowIcon {
                maxTextWidth: Math.max(0, centerContainer.width - 56)
            }
        }
    }
}
