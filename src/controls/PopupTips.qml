import QtQuick 2.4
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import HeeraUI 1.0 as HeeraUI

Window {
    id: control
    visible: false
    color: "transparent"

    property string popupText
    property point position: Qt.point(0, 0)

    flags: Qt.WindowStaysOnTopHint | Qt.WindowDoesNotAcceptFocus | Qt.ToolTip
    width: label.implicitWidth + HeeraUI.Units.largeSpacing * 2
    height: label.implicitHeight + HeeraUI.Units.largeSpacing * 2

    HeeraUI.RoundedRect {
        anchors.fill: parent

        opacity: 0.8

        Label {
            id: label
            anchors.centerIn: parent
            text: control.popupText
            color: HeeraUI.Theme.textColor
        }
    }

    onPositionChanged: adjustCorrectLocation()

    function adjustCorrectLocation() {
        var posX = control.position.x
        var posY = control.position.y

        // left
        if (posX < 0)
            posX = 1

        // top
        if (posY < 0)
            posY = 1

        // right
        if (posX + control.width > Screen.width)
            posX = Screen.width - control.width - 1

        // bottom
        if (posY > control.height > Screen.width)
            posY = Screen.width - control.width - 1

        control.x = posX
        control.y = posY
    }

    function show() {
        if (control.popupText)
            control.visible = true
    }

    function hide() {
        control.visible = false
    }
}
