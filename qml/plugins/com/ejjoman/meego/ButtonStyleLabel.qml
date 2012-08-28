/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import com.nokia.meego 1.1
import "uiconstants.js" as UI

Item {
    id: button

    // Common public API
    property alias text: label.text

    // Used in ButtonGroup.js to set the segmented look on the buttons.
    property string __buttonType

    // Styling for the Button
    property Style platformStyle: ButtonStyle {}

    // Deprecated, TODO remove
    property alias style: button.platformStyle

    implicitWidth: platformStyle.buttonWidth
    implicitHeight: platformStyle.buttonHeight
    width: implicitWidth

    property alias font: label.font

    //private property
    property bool __dialogButton: false

    BorderImage {
        id: background
        anchors.fill: parent
        border { left: button.platformStyle.backgroundMarginLeft; top: button.platformStyle.backgroundMarginTop;
                 right: button.platformStyle.backgroundMarginRight; bottom: button.platformStyle.backgroundMarginBottom }

        source: {
            if (__dialogButton)
                return button.platformStyle.dialog;
            else if(!enabled)
                return button.platformStyle.disabledBackground;
            else
                return button.platformStyle.background;
        }
    }

    Label {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: UI.BUTTON_LABEL_MARGIN
        anchors.right: parent.right
        anchors.rightMargin: UI.BUTTON_LABEL_MARGIN

        horizontalAlignment: button.platformStyle.horizontalAlignment
        elide: Text.ElideRight

        font.family: button.platformStyle.fontFamily
        font.weight: button.platformStyle.fontWeight
        font.pixelSize: button.platformStyle.fontPixelSize
        font.capitalization: button.platformStyle.fontCapitalization
        color: !enabled ? button.platformStyle.disabledTextColor : button.platformStyle.textColor;
        text: ""
        visible: text != ""
    }
}
