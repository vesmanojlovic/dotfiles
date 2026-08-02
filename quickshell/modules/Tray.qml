import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
    spacing: 6

    Repeater {
        model: SystemTray.items.values

        IconImage {
            required property var modelData

            implicitSize: 18
            // modelData.icon is already a resolved, ready-to-use Image
            // source (handles both named theme icons and apps like fcitx5
            // that only provide a raw IconPixmap with no name at all) -
            // do not re-run it through Quickshell.iconPath().
            source: modelData.icon

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton)
                        parent.modelData.secondaryActivate();
                    else
                        parent.modelData.activate();
                }
            }
        }
    }
}
