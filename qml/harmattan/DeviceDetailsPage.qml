import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import QtMobility.systeminfo 1.1
import "../plugins/com/ejjoman/meego" 1.0

import "uiconstants.js" as UIConstants

Page {
    id: root
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    property int deviceIndex: -1
    property variant device: undefined

    onDeviceIndexChanged: {
        if (root.deviceIndex == -1) {
            root.device = undefined
        } else {
            root.device = devices.get(root.deviceIndex)

            showOnStartscreenSwitch.init = true
            showOnStartscreenSwitch.checked = root.device.hasStarter //fileSystem.fileExists("/home/user/.local/share/applications/wakeonlan_harmattan_" + root.device.id + ".desktop")
            showOnStartscreenSwitch.init = false
        }
    }

    PageHeader {
        id: pageHeader
        useSheetHeaderBackground: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        title: (root.device ? root.device.Name : "")

        SheetButton {
            text: qsTr("Aufwecken")

            platformStyle: SheetButtonAccentStyle {
                background: "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"+__invertedString+"-background"
                pressedBackground: "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"+__invertedString+"-background-pressed"
                disabledBackground: "image://theme/" + theme.colorString + "meegotouch-sheet-button-accent"+__invertedString+"-background-disabled"
            }

            anchors {
                rightMargin: UIConstants.MARGIN_XLARGE
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            onClicked: {
                wakeOnLan.send(root.device.MAC, ":", root.device.Name)
            }
        }
    }

    Flickable {
        id: deviceFlickable
        clip: true
        anchors {
            //margins: UIConstants.MARGIN_XLARGE
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        PowerButton {
            anchors {
                centerIn: parent
                verticalCenterOffset: -col.height / 2
            }

            onClicked: {
                wakeOnLan.send(root.device.MAC, ":", root.device.Name)
            }
        }

        Column {
            id: col
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            ExtendedListItem {
                title: qsTr("Auf Startbildschirm anzeigen")

                onClicked: {
                    showOnStartscreenSwitch.checked = !showOnStartscreenSwitch.checked
                }

                Switch {
                    id: showOnStartscreenSwitch
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: UIConstants.MARGIN_XLARGE

                    property bool init: false

                    onCheckedChanged: {                        
                        if (!showOnStartscreenSwitch.init) {
                            if (showOnStartscreenSwitch.checked) {
                                if (devices.addStarter(root.device.id)) {
                                    infoBanner.text = qsTr("Starter hinzugefügt")
                                    infoBanner.iconSource = "../images/success.png"
                                } else {
                                    infoBanner.text = qsTr("Starter konnte nicht hinzugefügt werden")
                                    infoBanner.iconSource = "../images/error.png"

                                    showOnStartscreenSwitch.checked = false;
                                }
                            } else {
                                if (devices.removeStarter(root.device.id)) {
                                    infoBanner.text = qsTr("Starter entfernt")
                                    infoBanner.iconSource = "../images/success.png"
                                } else {
                                    infoBanner.text = qsTr("Starter konnte nicht entfernt werden")
                                    infoBanner.iconSource = "../images/error.png"
                                }
                            }

                            infoBanner.show();
                        }
                    }
                }
            }

            ExtendedListItem {
                title: qsTr("Befehl zum Aufwecken kopieren")

                Image {
                    source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: UIConstants.MARGIN_XLARGE
                }

                onClicked: {
                    deviceCommandSheet.deviceIndex = root.deviceIndex
                    deviceCommandSheet.open()
                }
            }
        }
    }

    DeviceCommandSheet {
        id: deviceCommandSheet
    }

    ScrollDecorator {
        flickableItem: deviceFlickable
    }

    InfoBanner {
        id: infoBanner
        z: 2
    }
}
