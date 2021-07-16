import QtQuick 2.15
import QtQuick.Window 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.15
import HeeraUI 1.0 as HeeraUI

Window {
    id: root
    width: 640
    height: 480
    visible: true
    flags: Qt.FramelessWindowHint
    color: "transparent"

    property alias backgroundColor: _background.color
    property alias headerBarHeight: _titlebar.height
    property bool hideHeaderOnMaximize: false
    property bool isMaximized: root.visibility === Window.Maximized
    property bool isFullScreen: root.visibility === Window.FullScreen

    property var edgeSize: HeeraUI.Units.largeRadius

    default property alias content : _content.data
    property Item headerBar

    onHeaderBarChanged: {
        headerBar.parent = _header
        headerBar.anchors.fill = _header
    }

    function toggleMaximized() {
        if (isMaximized) {
            root.showNormal();
        } else {
            root.showMaximized();
        }
    }

    HeeraUI.WindowShadow {
        view: root
        geometry: Qt.rect(root.x, root.y, root.width, root.height)
        radius: _background.radius
    }

    // Left bottom edge
    MouseArea {
        height: edgeSize
        width: height
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        cursorShape: Qt.SizeBDiagCursor
        propagateComposedEvents: true
        preventStealing: false
        visible: !isMaximized && !isFullScreen
        z: 999

        onPressed: mouse.accepted = false

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            target: null
            onActiveChanged: if (active) { root.startSystemResize(Qt.LeftEdge | Qt.BottomEdge) }
        }
    }

    // Right bottom edge
    MouseArea {
        height: edgeSize
        width: height
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        cursorShape: Qt.SizeFDiagCursor
        propagateComposedEvents: true
        preventStealing: false
        visible: !isMaximized && !isFullScreen
        z: 999

        onPressed: mouse.accepted = false

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            target: null
            onActiveChanged: if (active) { root.startSystemResize(Qt.RightEdge | Qt.BottomEdge) }
        }
    }

    // Bottom edge
    MouseArea {
        height: edgeSize / 2
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: edgeSize * 2
        anchors.rightMargin: edgeSize * 2
        cursorShape: Qt.SizeVerCursor
        visible: !isMaximized && !isFullScreen
        z: 999

        onPressed: mouse.accepted = false

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            target: null
            onActiveChanged: if (active) { root.startSystemResize(Qt.BottomEdge) }
        }
    }

    // Left edge
    MouseArea {
        width: edgeSize / 2
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: edgeSize
        anchors.bottomMargin: edgeSize * 2
        cursorShape: Qt.SizeHorCursor
        visible: !isMaximized && !isFullScreen
        z: 999

        onPressed: mouse.accepted = false

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            target: null
            onActiveChanged: if (active) { root.startSystemResize(Qt.LeftEdge) }
        }
    }

    // Right edge
    MouseArea {
        width: edgeSize / 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: edgeSize
        anchors.bottomMargin: edgeSize * 2
        cursorShape: Qt.SizeHorCursor
        visible: !isMaximized && !isFullScreen
        z: 999

        onPressed: mouse.accepted = false

        DragHandler {
            grabPermissions: TapHandler.CanTakeOverFromAnything
            target: null
            onActiveChanged: if (active) { root.startSystemResize(Qt.RightEdge) }
        }
    }

    Rectangle {
        id: _background
        anchors.fill: parent
        anchors.margins: 0
        radius: !isMaximized && !isFullScreen ? HeeraUI.Units.largeRadius : 0
        color: HeeraUI.Theme.primaryBackgroundColor
        antialiasing: true

        Behavior on color {
            ColorAnimation {
                duration: 125
                easing.type: Easing.InOutCubic
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            radius: parent.radius
            border.color: "black"
            opacity: 0.4
            antialiasing: true
            visible: !isMaximized && !isFullScreen
            z: 999
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            color: "transparent"
            radius: parent.radius
            border.color: HeeraUI.Theme.disabledTextColor
            antialiasing: true
            visible: !isMaximized && !isFullScreen && HeeraUI.Theme.darkMode
            z: 999
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: _background.width
                height: _background.height

                Rectangle {
                    anchors.fill: parent
                    radius: _background.radius
                }
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: !isMaximized && !isFullScreen ? 1 : 0
            spacing: 0

            Item {
                id: _titlebar
                Layout.fillWidth: true
                height: 40

                Item {
                    anchors.fill: parent

                    TapHandler {
                        onTapped: if (tapCount === 2) toggleMaximized()
                        gesturePolicy: TapHandler.DragThreshold
                    }

                    DragHandler {
                        acceptedDevices: PointerDevice.GenericPointer
                        grabPermissions:  PointerHandler.CanTakeOverFromItems | PointerHandler.CanTakeOverFromHandlersOfDifferentType | PointerHandler.ApprovesTakeOverByAnything
                        onActiveChanged: if (active) { root.startSystemMove() }
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.rightMargin: HeeraUI.Units.smallSpacing
                    spacing: HeeraUI.Units.largeSpacing

                    Item {
                        id: _header
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                    WindowButton {
                        size: 35
                        source: "qrc:/heera/kit/images/" + (HeeraUI.Theme.darkMode ? "dark/" : "light/") + "minimize.svg"
                        onClicked: root.showMinimized()
                        visible: root.visibility !== Window.FullScreen
                    }

                    WindowButton {
                        size: 35
                        source: "qrc:/heera/kit/images/" +
                            (HeeraUI.Theme.darkMode ? "dark/" : "light/") +
                            (root.visibility === Window.Maximized ? "restore.svg" : "maximize.svg")
                        onClicked: root.toggleMaximized()
                        visible: root.visibility !== Window.FullScreen
                    }

                    WindowButton {
                        size: 35
                        source: "qrc:/heera/kit/images/" + (HeeraUI.Theme.darkMode ? "dark/" : "light/") + "close.svg"
                        onClicked: root.close()
                        visible: root.visibility !== Window.FullScreen
                    }
                }
            }

            Item {
                id: _content
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
        }
    }
}
