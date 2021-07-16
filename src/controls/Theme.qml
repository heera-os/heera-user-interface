pragma Singleton

import QtQuick 2.4
import HeeraUI.Core 1.0 as HeeraUICore

QtObject {
    id: theme

    property bool darkMode: HeeraUICore.ThemeManager.darkMode

    property color blueColor: HeeraUICore.ThemeManager.blueColor
    property color redColor: HeeraUICore.ThemeManager.redColor
    property color greenColor: HeeraUICore.ThemeManager.greenColor
    property color purpleColor: HeeraUICore.ThemeManager.purpleColor
    property color pinkColor: HeeraUICore.ThemeManager.pinkColor
    property color orangeColor: HeeraUICore.ThemeManager.orangeColor

    property color primaryBackgroundColor: darkMode ? "#2c2c39" : "#edf5ff"
    property color secondaryBackgroundColor: darkMode ? "#22222c" : "#dce4ed"
    property color tertiaryBackgroundColor: darkMode ? "#16161d" : "#ced5de"

    property color textColor: darkMode ? "#FFFFFF" : "#171A20"
    property color disabledTextColor: darkMode ? "#888888" : "#5c5c5c"

    property color highlightColor: HeeraUICore.ThemeManager.accentColor
    property color highlightedTextColor: darkMode ? "#FFFFFF" : "#FFFFFF"

    property color activeTextColor: "#0176D3"
    property color activeBackgroundColor: "#0176D3"

    property color linkColor: "#2196F3"
    property color linkBackgroundColor: "#2196F3"
    property color visitedLinkColor: "#2196F3"
    property color visitedLinkBackgroundColor: "#2196F3"

    property color titleBarTextColor: darkMode ? "#cacbce" : "#383838"

    property font defaultFont: fontMetrics.font
    property font smallFont: {
        let font = fontMetrics.font
        if (!!font.pixelSize) {
            font.pixelSize =- 2
        } else {
            font.pointSize =- 2
        }
        return font
    }

    property list<QtObject> children: [
        TextMetrics {
            id: fontMetrics
        }
    ]
}
