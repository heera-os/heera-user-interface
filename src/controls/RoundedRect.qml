import QtQuick 2.4
import QtQuick.Controls 2.4
import HeeraUI 1.0 as HeeraUI

Item {
    id: control

    property real radius: HeeraUI.Units.smallRadius
    property var color: HeeraUI.Theme.primaryBackgroundColor

    Rectangle {
        id: _border
        anchors.fill: parent
        radius: control.radius
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.4)
        smooth: true
        antialiasing: true
    }

    Rectangle {
        id: _border2
        anchors.fill: parent
        anchors.margins: 1
        radius: control.radius - 1
        color: "transparent"
        border.color: Qt.rgba(255, 255, 255, 0.2)
        border.width: 1
    }

    Rectangle {
        id: _background
        anchors.fill: parent
        anchors.margins: 2
        color: control.color
        radius: control.radius - 2
        antialiasing: true
        smooth: true
    }
}
