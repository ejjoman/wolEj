/****************************************************************************
**
** Copyright (C) 2012 Róbert Márki
**
** This file is part of Web Feeds.
**
** Web Feeds is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** Web Feeds is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with Web Feeds.  If not, see <http://www.gnu.org/licenses/>.
****************************************************************************/

import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "uiconstants.js" as UIConstants

Sheet {
    id: root
    property Button acceptButton
    property alias contentItem: contentParent.children
    property string busyText : qsTr("Busy")
    property bool busy: false

    Component.onCompleted: {
        root.acceptButton = root.getButton("acceptButton");
        root.acceptButton.enabled = false;

        root.acceptButton.platformStyle.background =
                "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"
                + root.acceptButton.platformStyle.__invertedString + "-background";

        root.acceptButton.platformStyle.pressedBackground =
                "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"
                + root.acceptButton.platformStyle.__invertedString + "-background-pressed";

        root.acceptButton.platformStyle.disabledBackground =
                "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"
                + root.acceptButton.platformStyle.__invertedString + "-background-disabled";
    }

    function showMessage(message) {
        infoBanner.text = message;
        infoBanner.show();
    }

    InfoBanner {
        id: infoBanner
    }

    content: Item {
        anchors.fill: parent

        Item {
            id: contentParent
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: UIConstants.DEFAULT_MARGIN
            anchors.bottom: parent.bottom
        }

        Column {
            id: busyItem
            visible: false
            width: parent.width
            spacing: UIConstants.DEFAULT_HALF_MARGIN
            anchors.centerIn: parent
            BusyIndicator {
                anchors.horizontalCenter: parent.horizontalCenter
                running: true
                platformStyle: BusyIndicatorStyle { size: "large" }
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.busyText
                font.pointSize: UIConstants.FONT_SLARGE
                font.bold: true
            }
        }
    }

    Item {
        id: privateItem
        property Item originalParent: null
        states: [
            State {
                name: "BUSY"
                when: root.busy
                PropertyChanges {
                    target: contentParent
                    visible: false
                }
                PropertyChanges {
                    target: busyItem
                    visible: true
                }
                PropertyChanges {
                    target: root.acceptButton
                    enabled: false
                }
            }
        ]
    }
}
