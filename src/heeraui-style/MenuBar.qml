import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import HeeraUI 1.0 as HeeraUI

T.MenuBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: 40

    delegate: MenuBarItem {
        implicitWidth: _item.implicitWidth + HeeraUI.Units.largeSpacing * 2 + padding
        implicitHeight: 40
        id: item

        contentItem: Item {
            id: _item
            implicitWidth: label.implicitWidth + HeeraUI.Units.largeSpacing * 2

            Label {
                leftPadding: 2
                anchors.centerIn: parent
                id: label
                text: item.text
                color: item.enabled ? HeeraUI.Theme.textColor : HeeraUI.Theme.disabledTextColor
            }
        }

        background: Rectangle {
            implicitWidth: item.width
            implicitHeight: 40

            color: HeeraUI.Theme.tertiaryBackgroundColor
            opacity: item.down ? 1 : 0.4
            Behavior on opacity {
                NumberAnimation {
                    duration: 125
                    easing.type: Easing.InOutCubic
                }
            }
        }
    }

    contentItem: Row {
        Repeater {
            model: control.contentModel
        }
    }

    background: Rectangle {
        implicitHeight: 40
        color: "transparent"
    }
}
