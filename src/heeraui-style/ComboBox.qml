/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Window 2.4
import QtQuick.Controls 2.4
import QtQuick.Controls.impl 2.4
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.0
import HeeraUI 1.0 as HeeraUI

T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    topInset: HeeraUI.Units.smallSpacing
    bottomInset: HeeraUI.Units.smallSpacing

    spacing: HeeraUI.Units.smallSpacing
    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

    delegate: MenuItem {
        width: control.popup.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    indicator: Image {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        height: HeeraUI.Units.iconSizes.small
        width: height

        source: "image://icontheme/go-down"
        sourceSize.width: width
        sourceSize.height: height
    }

    contentItem: T.TextField {
        padding: HeeraUI.Units.smallSpacing
        leftPadding: control.editable ? 2 : control.mirrored ? 0 : 12
        rightPadding: control.editable ? 2 : control.mirrored ? 12 : 0

        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator

        font: control.font
        color: control.enabled ? control.HeeraUI.Theme.textColor : control.HeeraUI.Theme.highlightColor
        selectionColor:  control.HeeraUI.Theme.highlightColor
        selectedTextColor: control.HeeraUI.Theme.highlightedTextColor
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth:  (HeeraUI.Units.iconSizes.medium * 3) + HeeraUI.Units.largeSpacing
        implicitHeight: HeeraUI.Units.iconSizes.medium + HeeraUI.Units.smallSpacing

        radius: HeeraUI.Units.smallRadius

        color: !control.editable ? control.HeeraUI.Theme.primaryBackgroundColor : "transparent"

        border.color: Qt.tint(HeeraUI.Theme.textColor, Qt.rgba(HeeraUI.Theme.primaryBackgroundColor.r, HeeraUI.Theme.primaryBackgroundColor.g, HeeraUI.Theme.primaryBackgroundColor.b, 0.7))

        Rectangle {
            visible: control.editable
            y: parent.y + control.baselineOffset
            width: parent.width
            height: control.activeFocus ? 2 : 1
            color: control.editable && control.activeFocus ? control.HeeraUI.Theme.highlightColor : control.HeeraUI.Theme.highlightedTextColor
        }
    }

    popup: T.Popup {
        width: Math.max(control.width, 150)
        implicitHeight: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        transformOrigin: Item.Top
        topMargin: HeeraUI.Units.largeSpacing
        bottomMargin: HeeraUI.Units.largeSpacing

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                easing.type: Easing.InOutCubic
                duration: 150
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.InOutCubic
                duration: 150
            }
        }

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0

            T.ScrollBar.vertical: ScrollBar {}
            // T.ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            radius: HeeraUI.Units.smallRadius
            color: parent.HeeraUI.Theme.primaryBackgroundColor
            border.color: Qt.tint(HeeraUI.Theme.textColor, Qt.rgba(HeeraUI.Theme.primaryBackgroundColor.r, HeeraUI.Theme.primaryBackgroundColor.g, HeeraUI.Theme.primaryBackgroundColor.b, 0.7))
            layer.enabled: true

            layer.effect: DropShadow {
                transparentBorder: true
                radius: 32
                samples: 32
                horizontalOffset: 0
                verticalOffset: 0
                color: Qt.rgba(0, 0, 0, 0.11)
            }
        }
    }
}
