import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import HeeraUI 1.0 as HeeraUI

T.MenuSeparator {
    id: control

    implicitHeight: HeeraUI.Units.smallSpacing + separator.height
    width: parent.width

    background: Rectangle {
        id: separator
        anchors.centerIn: control
        width: control.width - HeeraUI.Units.largeSpacing
        height: 1
        color: HeeraUI.Theme.textColor
        opacity: 0.3
    }
}
