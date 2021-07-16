import QtQuick 2.6
import QtQuick.Templates 2.3 as T
import QtGraphicalEffects 1.0
import HeeraUI 1.0 as HeeraUI

T.TabBar {
    id: control

    implicitWidth: Math.max(background.implicitWidth, contentItem.implicitWidth + HeeraUI.Units.smallSpacing)
    implicitHeight: contentItem.implicitHeight

    spacing: 0

    contentItem: ListView {
        id: listView
        implicitWidth: contentWidth
        implicitHeight: control.contentModel.get(0).height

        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 250
        highlightResizeDuration: 0
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 48
        preferredHighlightEnd: width - 48

        highlight: Item {
            Rectangle {
                anchors {
                    fill: parent
                    margins: 2
                }
                color: HeeraUI.Theme.highlightColor
                radius: HeeraUI.Units.smallRadius

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    radius: 2
                    samples: 2
                    horizontalOffset: 0
                    verticalOffset: 0
                    color: Qt.rgba(0, 0, 0, 0.11)
                }
            }
            x: listView.currentItem.x
            Behavior on x {
                NumberAnimation {
                    easing.type: Easing.InOutCubic
                }
            }
        }
    }

    background: Rectangle {
        color: HeeraUI.Theme.secondaryBackgroundColor
        radius: HeeraUI.Units.smallRadius + 2
    }
}
