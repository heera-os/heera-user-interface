import QtQuick 2.9
import QtQuick.Templates 2.5 as T
import HeeraUI 1.0 as HeeraUI

T.TabButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding)
    implicitHeight: HeeraUI.Units.iconSizes.medium + HeeraUI.Units.smallSpacing

    padding: 0
    spacing: 0

    contentItem: Text {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight

        text: control.text
        font: control.font
        color: !control.enabled ? HeeraUI.Theme.disabledTextColor : control.checked ? HeeraUI.Theme.highlightedTextColor : HeeraUI.Theme.textColor
    }
}
