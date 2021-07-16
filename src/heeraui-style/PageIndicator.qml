import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import HeeraUI 1.0 as HeeraUI

T.PageIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    spacing: HeeraUI.Units.smallSpacing

    delegate: Rectangle {
        implicitWidth: HeeraUI.Units.smallRadius
        implicitHeight: HeeraUI.Units.smallRadius

        radius: width / 2
        color: HeeraUI.Theme.textColor
        opacity: index === control.currentIndex ? 1.0 : 0.4
    }

    contentItem: Row {
        spacing: control.spacing

        Repeater {
            model: control.count
            delegate: control.delegate
        }
    }
}
