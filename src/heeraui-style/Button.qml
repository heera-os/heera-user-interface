import QtQuick 2.4
import QtQuick.Templates 2.4 as T
import HeeraUI 1.0 as HeeraUI
import QtQuick.Controls.impl 2.4

T.Button
{
    id: control
    implicitWidth: Math.max(background.implicitWidth, contentItem.implicitWidth + HeeraUI.Units.largeSpacing * 2)
    implicitHeight: background.implicitHeight
    hoverEnabled: true

    icon.width: HeeraUI.Units.iconSizes.small
    icon.height: HeeraUI.Units.iconSizes.small

    icon.color: control.enabled ? (control.highlighted ? control.HeeraUI.Theme.highlightColor : control.HeeraUI.Theme.textColor) : control.HeeraUI.Theme.disabledTextColor
    spacing: HeeraUI.Units.smallSpacing

    contentItem: Label {
        text: control.text
        color: !control.enabled ? control.HeeraUI.Theme.disabledTextColor :
        control.highlighted || control.pressed ? control.HeeraUI.Theme.highlightedTextColor : control.HeeraUI.Theme.textColor
        horizontalAlignment: Text.AlignHCenter
    }

    background: Rectangle {
        implicitWidth:  (HeeraUI.Units.iconSizes.medium * 3) + HeeraUI.Units.largeSpacing
        implicitHeight: HeeraUI.Units.iconSizes.medium + HeeraUI.Units.smallSpacing

        color: control.pressed ? HeeraUI.Theme.highlightColor
            : HeeraUI.Theme.primaryBackgroundColor
        ColorAnimation {
            duration: 90
            easing.type: Easing.InOutCubic
            id: _anim
        }
        Behavior on color {
            animation: _anim
        }
        border.color: control.activeFocus || control.pressed ? HeeraUI.Theme.highlightColor :
                      Qt.tint(HeeraUI.Theme.textColor, Qt.rgba(HeeraUI.Theme.primaryBackgroundColor.r, HeeraUI.Theme.primaryBackgroundColor.g, HeeraUI.Theme.primaryBackgroundColor.b, 0.7))
        Behavior on border.color {
            animation: _anim
        }
        border.width: HeeraUI.Units.devicePixelRatio
        radius: HeeraUI.Units.smallRadius
    }
}
