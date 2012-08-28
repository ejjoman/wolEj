import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

import "uiconstants.js" as UIConstants

Page {
    id: root
    tools: mainPageTools
    orientationLock: PageOrientation.LockPortrait

    AddDeviceSheet {
        id: addDeviceSheet

        onAccepted: {
            if (devices.deviceExists(addDeviceSheet.macAddress)) {
                infoBanner.text = qsTr("Ein Gerät mit dieser MAC-Adresse existiert bereits")
                infoBanner.show()

                return;
            }

            devices.addDevice(addDeviceSheet.deviceName.trim(), addDeviceSheet.macAddress, addDeviceSheet.defaultDevice);
            addDeviceSheet.resetInputFields();
        }

        onRejected: {
            addDeviceSheet.resetInputFields();
        }
    }

    PageHeader {
        id: pageHeader

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        title: qsTr("Wake On Lan")
    }

    Item {
        anchors {
            top: pageHeader.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            //margins: UIConstants.MARGIN_XLARGE
        }

        ListView {
            id: devicesList
            anchors.fill: parent
            visible: devices.count > 0
            model: devices

            delegate: ExtendedListItem {
                title: model.Name
                subTitle: model.MAC

                onClicked: {
                    pageStack.push(devicePage, {deviceIndex: model.index})
                }

                onPressAndHold: {
                    devices.selectedIndex = model.index
                    deviceContextMenu.open()
                }

                Image {
                    source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
                    anchors.right: parent.right
                    anchors.rightMargin: UIConstants.MARGIN_XLARGE
                    anchors.verticalCenter: parent.verticalCenter
                }



//                BorderImage {
//                    id: background
//                    anchors.fill: parent
//                    // Fill page porders
//                    anchors.leftMargin: -UIConstants.MARGIN_XLARGE
//                    anchors.rightMargin: -UIConstants.MARGIN_XLARGE
//                    source: "image://theme/" + theme.colorString + "meegotouch-list" + (theme.inverted ? "-inverted" : "") +"-background-selected-center"
//                    opacity: progress.value / progress.maximumValue

//                    Behavior on opacity {
//                        PropertyAnimation { duration: pressedTimer.interval }
//                    }
//                }



//                ProgressBar {
//                    id: progress

//                    anchors {
//                        top: parent.top
//                        left: parent.left
//                        right: parent.right
//                    }

//                    value: pressedTimer.triggerCount
//                    visible: false //value > 0
//                    maximumValue: pressedTimer.maxTriggerCount
//                }

//                function updateProgressBar(triggerCount, maxTriggerCount) {
//                    progress.maximumValue = maxTriggerCount;
//                    progress.value = triggerCount;
//                }



//                onPressedChanged: {
//                    if (pressed) {
//                        pressedTimer.start()
//                    } else {
//                        pressedTimer.stop()
//                    }
//                }

//                Timer {
//                    id: pressedTimer
//                    interval: 100
//                    repeat: true
//                    property int triggerCount: 0
//                    property int maxTriggerCount: 10

//                    onTriggered: {
//                        if (triggerCount == maxTriggerCount) {
//                            stop();

//                            if (wakeOnLan.send(model.MAC, ":", model.Name))
//                                infoBanner.text = "Magisches Paket wurde an " + model.Name + " gesendet"
//                            else
//                                infoBanner.text = "Das magische Paket kann nicht gesendet werden, da keine Verbindung mit dem WLAN besteht"

//                            infoBanner.show()
//                        } else {
//                            triggerCount++;
//                        }
//                    }

//                    onRunningChanged: {
//                        if (!running)
//                            triggerCount = 0
//                    }
//                }
            }
        }

        ScrollDecorator {
            flickableItem: devicesList
        }

        EmptyListInfoLabel {
            text: qsTr("Keine Geräte vorhanden")
            anchors.fill: parent
            visible: devices.count == 0
        }
    }

    ToolBarLayout {
        id: mainPageTools
        visible: true

        ToolIcon {
            platformIconId: "toolbar-add"
            anchors.centerIn: parent
            onClicked: {
                addDeviceSheet.open();
            }
        }

        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: {
                if (mainMenu.status === DialogStatus.Closed)
                    mainMenu.open()
                else
                    mainMenu.close()
            }
        }
    }

    AboutPage {
        id: aboutPage
    }

    Menu {
        id: mainMenu
        //visualParent: pageStack

        MenuLayout {
            MenuItem {
                text: qsTr("Alle Geräte löschen")
                onClicked: deleteAllDevicesQueryDialog.open()
                enabled: devices.count > 0
            }

            MenuItem {
                text: qsTr("Über Wake On Lan")
                onClicked: {
                    pageStack.push(aboutPage)
                }
            }
        }

        onStatusChanged: {
            //appWindow.showToolBar = (status === DialogStatus.Closed)
        }
    }

    ContextMenu {
        id: deviceContextMenu

        MenuLayout {
            MenuItem {
                id: wakeDeviceMenuItem

                onClicked: {
                    wakeOnLan.send(devices.getSelectedItem().MAC, ":", devices.getSelectedItem().Name)
                }
            }

            MenuItem {
                id: deleteDeviceMenuItem

                onClicked: {
                    deleteDeviceQueryDialog.open()
                }
            }
        }

        onStatusChanged: {
            if (deviceContextMenu.status === DialogStatus.Opening) {
                wakeDeviceMenuItem.text = qsTr("Gerät '%1' aufwecken").arg(devices.getSelectedItem().Name)
                deleteDeviceMenuItem.text = qsTr("Gerät '%1' löschen").arg(devices.getSelectedItem().Name)
            }
        }
    }

    QueryDialog {
        id: deleteDeviceQueryDialog
        acceptButtonText: qsTr("Löschen")
        rejectButtonText: qsTr("Abbrechen")

        onStatusChanged: {
            if (deleteDeviceQueryDialog.status === DialogStatus.Opening) {
                deleteDeviceQueryDialog.titleText = qsTr("'%1' löschen?").arg(devices.getSelectedItem().Name)
                deleteDeviceQueryDialog.message = qsTr("Soll das Gerät '%1' gelöscht werden?").arg(devices.getSelectedItem().Name)
            }
        }

        onAccepted: {
            devices.deleteDevice(devices.getSelectedItem().id)
        }
    }

    QueryDialog {
        id: deleteAllDevicesQueryDialog
        titleText: qsTr("Alle Geräte löschen?")
        message: qsTr("Sollen wirklich alle Geräte gelöscht werden?")
        acceptButtonText: qsTr("Alle löschen")
        rejectButtonText: qsTr("Abbrechen")

        onAccepted: {
            devices.clearDevices();
        }
    }

    Component.onCompleted: {
        //theme.inverted = true
        theme.colorScheme = "blue4"
    }
}
