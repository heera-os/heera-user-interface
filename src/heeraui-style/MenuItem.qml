import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

import HeeraUI 1.0 as HeeraUI

T.MenuItem
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: visible ? Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                       implicitContentHeight + topPadding + bottomPadding,
                                       implicitIndicatorHeight + topPadding + bottomPadding) : 0
    verticalPadding: HeeraUI.Units.smallSpacing

    icon.width: HeeraUI.Units.iconSizes.medium
    icon.height: HeeraUI.Units.iconSizes.medium

    icon.color: control.enabled ? (control.highlighted ? control.HeeraUI.Theme.highlightColor : control.HeeraUI.Theme.textColor) :
                             control.HeeraUI.Theme.disabledTextColor

    contentItem: IconLabel {
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        leftPadding: !control.mirrored ? indicatorPadding + HeeraUI.Units.smallSpacing * 2 : arrowPadding
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding + HeeraUI.Units.smallSpacing * 2

        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: Qt.AlignLeft

        icon: control.icon
        text: control.text
        font: control.font
        color: control.enabled ? control.highlighted || control.pressed ? control.HeeraUI.Theme.highlightedTextColor :
               control.HeeraUI.Theme.textColor : control.HeeraUI.Theme.disabledTextColor
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: control.visible ? HeeraUI.Units.rowHeightAlt : 0
        radius: 4
        opacity: 1

        anchors {
            fill: parent
            leftMargin: HeeraUI.Units.smallSpacing
            rightMargin: HeeraUI.Units.smallSpacing
        }

        color: control.highlighted || control.pressed ? control.HeeraUI.Theme.highlightColor : "transparent"
    }
}
