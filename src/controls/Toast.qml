import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import HeeraUI 1.0 as HeeraUI

Item {
    id: _toast
    //visible: open
    Layout.alignment: Qt.AlignBottom | Qt.AlignLeft
    width: open ? _layout.implicitWidth + (HeeraUI.Units.largeSpacing * 2) : 0
    height: _layout.implicitHeight + (HeeraUI.Units.largeSpacing * 2)
    clip: false

    Behavior on width {
        NumberAnimation {
            duration: 500
            easing.type: Easing.InOutCubic
        }
    }

    property string text: ""
    /**
        Possible types:
            - info: Gray toast
            - success: Green toast
            - warn: Yellow toast
            - error: Red toast
    */
    property string type: "error"
    property bool hasCloseButton: true
    property bool open: false

    onOpenChanged: {
        _timer.restart()
    }

    Timer {
        id: _timer
        interval: 5000
        running: false
        repeat: false
        onTriggered: _toast.open = false
    }

    function getColorFromType() {
        switch(_toast.type) {
            case "info":
                return HeeraUI.Theme.blueColor
            case "success":
                return HeeraUI.Theme.greenColor
            case "warn":
                return HeeraUI.Theme.orangeColor
            case "error":
                return HeeraUI.Theme.redColor
            default:
                console.log("Toast: invalid type")
                return;
        }
    }

    Rectangle {
        radius: HeeraUI.Units.largeRadius
        color: getColorFromType()
        anchors.fill: parent

        RowLayout {
            id: _layout
            anchors.fill: parent
            anchors.margins: HeeraUI.Units.smallSpacing

            Image {
                // Icon for toast, determined by type
                width: 22
                height: width
                sourceSize.width: width
                sourceSize.height: height
                source: `qrc:/HeeraUI/kit/images/toast/${_toast.type}.svg`
                Layout.margins: HeeraUI.Units.smallSpacing
            }

            Label {
                Layout.alignment: Qt.AlignVCenter
                text: _toast.text
                color: HeeraUI.Theme.highlightedTextColor
            }

            Item {
                Layout.fillWidth: true
            }

            Image {
                visible: _toast.hasCloseButton
                Layout.leftMargin: HeeraUI.Theme.largeSpacing
                width: 32
                height: 32
                source: "qrc:/HeeraUI/kit/images/toast/close.svg"

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onClicked: {
                        _toast.open = false
                    }
                }
            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8.0
            samples: 17
            color: "#80000000"
        }
    }
}
