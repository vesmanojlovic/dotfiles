import QtQuick
import Quickshell

// Reusable dropdown: a real separate PopupWindow anchored below a trigger
// item, so it isn't clipped by the (32px-tall) bar window it's opened from.
PopupWindow {
    id: root

    required property Item anchorItem
    default property alias data: contentColumn.data

    function toggle() {
        visible = !visible;
    }

    function close() {
        visible = false;
    }

    anchor.item: anchorItem
    anchor.edges: Edges.Bottom | Edges.Left
    anchor.gravity: Edges.Bottom | Edges.Right
    anchor.adjustment: PopupAdjustment.Slide

    grabFocus: true

    implicitWidth: Math.max(140, contentColumn.implicitWidth + 16)
    implicitHeight: contentColumn.implicitHeight + 16

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        border.color: "#444444"
        radius: 4
    }

    Column {
        id: contentColumn
        anchors.fill: parent
        anchors.margins: 8
        spacing: 6
    }
}
