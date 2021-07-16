import QtQuick 2.4
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import HeeraUI 1.0 as HeeraUI

Image {
    id: control
    width: 22
    height: width
    source: "qrc:/heeraui/kit/images/refresh.svg"
    sourceSize: Qt.size(width, height)
    visible: true

    property alias running: rotationAnimator.running

    ColorOverlay {
        anchors.fill: control
        source: control
        color: HeeraUI.Theme.textColor
        opacity: 1
        visible: true
    }

    RotationAnimator {
        id: rotationAnimator
        target: control
        running: control.visible
        from: 360
        to: 0
        loops: Animation.Infinite
        duration: 1000
    }
}
