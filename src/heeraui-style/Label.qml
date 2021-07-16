import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Templates 2.3 as T
import HeeraUI 1.0 as HeeraUI

T.Label {
    id: control

    verticalAlignment: lineCount > 1 ? Text.AlignTop : Text.AlignVCenter

    activeFocusOnTab: false
    //Text.NativeRendering is broken on non integer pixel ratios
    renderType: Window.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering

    font.capitalization: HeeraUI.Theme.defaultFont.capitalization
    font.family: HeeraUI.Theme.defaultFont.family
    font.italic: HeeraUI.Theme.defaultFont.italic
    font.letterSpacing: HeeraUI.Theme.defaultFont.letterSpacing
    font.pointSize: HeeraUI.Theme.defaultFont.pointSize
    font.strikeout: HeeraUI.Theme.defaultFont.strikeout
    font.underline: HeeraUI.Theme.defaultFont.underline
    font.weight: HeeraUI.Theme.defaultFont.weight
    font.wordSpacing: HeeraUI.Theme.defaultFont.wordSpacing
    color: HeeraUI.Theme.textColor
    linkColor: HeeraUI.Theme.linkColor

    opacity: enabled? 1 : 0.6

    Accessible.role: Accessible.StaticText
    Accessible.name: text
}
