import QtQuick
import QtQuick.Layouts

// Shared pill background for a bar section: 60% opaque black, rounded,
// sized to its content with padding.
Rectangle {
    id: island

    default property alias data: row.data
    property alias spacing: row.spacing

    color: "#99000000"
    radius: 8

    implicitWidth: row.implicitWidth + 16
    implicitHeight: row.implicitHeight + 8

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8
    }
}
