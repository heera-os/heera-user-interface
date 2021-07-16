/*
 * Copyright 2017 Marco Martin <mart@kde.org>
 * Copyright 2017 The Qt Company Ltd.
 *
 * GNU Lesser General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU Lesser
 * General Public License version 3 as published by the Free Software
 * Foundation and appearing in the file LICENSE.LGPLv3 included in the
 * packaging of this file. Please review the following information to
 * ensure the GNU Lesser General Public License version 3 requirements
 * will be met: https://www.gnu.org/licenses/lgpl.html.
 *
 * GNU General Public License Usage
 * Alternatively, this file may be used under the terms of the GNU
 * General Public License version 2.0 or later as published by the Free
 * Software Foundation and appearing in the file LICENSE.GPL included in
 * the packaging of this file. Please review the following information to
 * ensure the GNU General Public License version 2.0 requirements will be
 * met: http://www.gnu.org/licenses/gpl-2.0.html.
 */


import QtQuick 2.6
import QtQuick.Window 2.1
import QtQuick.Controls 2.3 as Controls
import QtQuick.Templates 2.3 as T
import HeeraUI 1.0 as HeeraUI

T.TextField {
    id: control

    implicitWidth: Math.max(200,
                            placeholderText ? placeholder.implicitWidth + leftPadding + rightPadding : 0)
                            || contentWidth + leftPadding + rightPadding
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             background ? background.implicitHeight : 0,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6

    //Text.NativeRendering is broken on non integer pixel ratios
    renderType: Window.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
    
    color: control.enabled ? HeeraUI.Theme.textColor : HeeraUI.Theme.disabledTextColor
    selectionColor: HeeraUI.Theme.highlightColor
    selectedTextColor: HeeraUI.Theme.highlightedTextColor
	
	verticalAlignment: TextInput.AlignVCenter
    horizontalAlignment: Text.AlignLeft
	
// 	cursorDelegate: CursorDelegate { }

    Controls.Label {
		id: placeholder
		x: control.leftPadding
		y: control.topPadding
		width: control.width - (control.leftPadding + control.rightPadding)
		height: control.height - (control.topPadding + control.bottomPadding)
		
		text: control.placeholderText
		font: control.font
        color: HeeraUI.Theme.textColor
		opacity: 0.4
        horizontalAlignment: Text.AlignLeft
		verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
		wrapMode: Text.NoWrap
	}

	background: Rectangle {
        implicitWidth: 1 * 120
        implicitHeight: HeeraUI.Units.iconSizes.medium + HeeraUI.Units.smallSpacing
        color: control.activeFocus ? Qt.lighter(HeeraUI.Theme.primaryBackgroundColor, 1.4)
        : (control.hovered ? Qt.lighter(HeeraUI.Theme.primaryBackgroundColor, 1.3) : HeeraUI.Theme.primaryBackgroundColor)

        border.color: control.activeFocus ? HeeraUI.Theme.highlightColor :
                      Qt.tint(HeeraUI.Theme.textColor, Qt.rgba(HeeraUI.Theme.primaryBackgroundColor.r, HeeraUI.Theme.primaryBackgroundColor.g, HeeraUI.Theme.primaryBackgroundColor.b, 0.7))
        
        ColorAnimation {
            id: _colorAnimation
            duration: 125
            easing.type: Easing.InOutCubic
        }
        Behavior on color { animation: _colorAnimation }
        Behavior on border.color { animation: _colorAnimation }

        radius: HeeraUI.Units.smallRadius
        border.width: 1
	}
}
