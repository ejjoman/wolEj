// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

import com.ejjoman.plugins 1.0

import "../plugins/com/ejjoman/meego" 1.0
import "../plugins/com/ejjoman/meego/uiconstants.js" as UIConstants

ExtendedSheet {
    id: root

    acceptButtonText: "Hinzufügen"
    rejectButtonText: "Abbrechen"

    function updateAcceptButton() {
        if (root.acceptButton !== null)
            acceptButton.enabled = deviceNameTextField.text.trim().length > 0 && macAdressButtonRow.validSelection
    }

    function resetInputFields() {
        deviceNameTextField.text = "";
        macAdressButtonRow.reset();
    }

    property alias deviceName: deviceNameTextField.text
    property alias macAddress: macAdressButtonRow.selectedMacAddress

    contentItem: Item {
        anchors.fill: parent

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: wrapperCol.childrenRect.height

            Column {
                id: wrapperCol
                anchors.leftMargin: UIConstants.DEFAULT_MARGIN
                anchors.rightMargin: UIConstants.DEFAULT_MARGIN

                spacing: 40 //UIConstants.DEFAULT_MARGIN

                anchors.fill: parent

                Row {
                    width: parent.width

                    Column {
                        width: parent.width

                        Label {
                            anchors {
                                left: parent.left
                            }

                            platformStyle: LabelStyle {
                                fontFamily: "Nokia Pure Text Light"
                                fontPixelSize: 22
                            }

                            text: "Name des Geräts"
                        }

                        TextField {
                            id: deviceNameTextField

                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            placeholderText: "Gerätename eingeben"

                            onTextChanged: root.updateAcceptButton()
                        }
                    }
                }

                Row {
                    width: parent.width

                    Column {
                        width: parent.width

                        Label {
                            anchors {
                                left: parent.left
                            }

                            platformStyle: LabelStyle {
                                fontFamily: "Nokia Pure Text Light"
                                fontPixelSize: 22
                            }

                            text: "MAC-Adresse des Geräts"
                        }

                        SelectMacAdressButtonRow {
                            id: macAdressButtonRow

                            onValidSelectionChanged: {
                                console.debug(macAdressButtonRow.validSelection)
                                root.updateAcceptButton();
                            }

                            onOpenParseMacAddressQueryDialog: parseMacAddressQueryDialog.open()
                        }

                    }
                }

                Row {
                    width: parent.width

                    Column {
                        width: parent.width

                        Label {
                            anchors {
                                left: parent.left
                            }

                            platformStyle: LabelStyle {
                                fontFamily: "Nokia Pure Text Light"
                                fontPixelSize: 22
                            }

                            text: "... oder MAC aus Zwischenablage einfügen"
                        }

                        Button {
                            id: parseFromClipboard
                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            text: "Einfügen"
                            onClicked: {
                                parseMacAddressQueryDialog.open()
                            }
                        }

                    }
                }

//                Row {
//                    //anchors.left: parent.left
//                    //anchors.right: parent.right

//                    width: parent.width

//                    Label {
//                        anchors {
//                            left: parent.left
//                            verticalCenter: parent.verticalCenter
//                        }

//                        platformStyle: LabelStyle {
//                            fontFamily: "Nokia Pure Text Light"
//                            fontPixelSize: 22
//                        }

//                        text: "Als standard festlegen"
//                    }

//                    Switch {
//                        id: defaultDeviceSwitch

//                        anchors {
//                            right: parent.right
//                            verticalCenter: parent.verticalCenter
//                        }
//                    }
//                }
            }
        }

        ScrollDecorator {
            flickableItem: flickable
        }
    }

    Clipboard {
        id: clipboard
    }

    InfoBanner {
        id: infoBanner
        z: 2
    }

    QueryDialog {
        id: parseMacAddressQueryDialog
        icon: "../images/globe.png"
        titleText: "MAC-Adresse einfügen"
        message: "Kopiere die MAC-Adresse aus einer anderen Anwendung und drücke 'Einfügen'"
        acceptButtonText: "Einfügen"
        rejectButtonText: "Abbrechen"

        onAccepted: {
            var valid = macAdressButtonRow.parseMac(clipboard.getText());

            if (valid) {
                infoBanner.text = "MAC-Adresse aus der Zwischenablage übernommen"
                infoBanner.iconSource = "../images/success.png"
            } else {
                infoBanner.text = "Keine gültige MAC-Adresse in der Zwischenablage gefunden"
                infoBanner.iconSource = "../images/error.png"
            }

            infoBanner.show()
        }
    }
}

