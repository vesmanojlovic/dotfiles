import QtQuick

import "../services" as Services

Text {
    color: "white"
    text: "⏻"

    MouseArea {
        anchors.fill: parent
        onClicked: Services.PowerMenuState.toggle()
    }
}
