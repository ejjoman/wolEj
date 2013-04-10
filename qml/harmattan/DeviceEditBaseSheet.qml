// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

import com.ejjoman.plugins 1.0

import "../plugins/com/ejjoman/meego" 1.0
import "../plugins/com/ejjoman/meego/uiconstants.js" as UIConstants

ExtendedSheet {
    id: root

    acceptButtonText: qsTr("Hinzufügen")
    rejectButtonText: qsTr("Abbrechen")

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

                spacing: UIConstants.DEFAULT_MARGIN

                anchors {
                    left: parent.left
                    right: parent.right
                }

                //anchors.fill: parent

                Row {
                    width: parent.width

                    Column {
                        width: parent.width

                        SectionHeading {
                            section: "Name des Geräts"
                        }

//                        Label {
//                            anchors {
//                                left: parent.left
//                            }

//                            platformStyle: LabelStyle {
//                                fontFamily: "Nokia Pure Text Light"
//                                fontPixelSize: 22
//                            }

//                            text: qsTr("Name des Geräts")
//                        }

                        TextField {
                            id: deviceNameTextField

                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            placeholderText: qsTr("Name des Geräts")

                            onTextChanged: root.updateAcceptButton()
                        }
                    }
                }

                Row {
                    width: parent.width

                    Column {
                        width: parent.width

//                        Label {
//                            anchors {
//                                left: parent.left
//                            }

//                            platformStyle: LabelStyle {
//                                fontFamily: "Nokia Pure Text Light"
//                                fontPixelSize: 22
//                            }

//                            text: qsTr("MAC-Adresse des Geräts")
//                        }

                        SectionHeading {
                            section: qsTr("MAC-Adresse des Geräts")
                        }

                        Column {
                            spacing: UIConstants.DEFAULT_MARGIN

                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            Label {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }

                                platformStyle: LabelStyle {
                                    fontFamily: "Nokia Pure Text Light"
                                    fontPixelSize: UIConstants.FONT_SMALL
                                }
                                wrapMode: Text.WordWrap
                                color: !theme.inverted ? UIConstants.COLOR_SECONDARY_FOREGROUND : UIConstants.COLOR_INVERTED_SECONDARY_FOREGROUND

                                text: qsTr("Die MAC-Adresse kann entweder manuell eingegeben, oder aus einer anderen Anwendung kopiert und mit dem &nbsp;&nbsp;<img src=\"%1\" /> -Button eingefügt werden.").arg("../images/icon-m-common-search-cropped" + (theme.inverted ? "-inverse" : "") + ".png")
                                textFormat: Text.RichText
                            }

                            Row {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }

                                TextField {
                                    id: macGroup1
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 2)
                                            macGroup2.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }

                                TextField {
                                    id: macGroup2
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 2)
                                            macGroup3.forceActiveFocus()
                                        else if (text.length == 0)
                                            macGroup1.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }

                                TextField {
                                    id: macGroup3
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 2)
                                            macGroup4.forceActiveFocus()
                                        else if (text.length == 0)
                                            macGroup2.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }

                                TextField {
                                    id: macGroup4
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 2)
                                            macGroup5.forceActiveFocus()
                                        else if (text.length == 0)
                                            macGroup3.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }

                                TextField {
                                    id: macGroup5
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 2)
                                            macGroup6.forceActiveFocus()
                                        else if (text.length == 0)
                                            macGroup4.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }

                                TextField {
                                    id: macGroup6
                                    inputMask: "HH"
                                    inputMethodHints: Qt.ImhUppercaseOnly | Qt.ImhNoPredictiveText
                                    maximumLength: 2
                                    onTextChanged: {
                                        if (text.length == 0)
                                            macGroup5.forceActiveFocus()
                                    }

                                    width: parent.width / 6
                                }
                            }

                            SelectMacAdressButtonRow {
                                id: macAdressButtonRow
                                showParseMacAddressButton: true
                                onValidSelectionChanged: {
                                    console.debug(macAdressButtonRow.validSelection)
                                    root.updateAcceptButton();
                                }

                                onOpenParseMacAddressQueryDialog: parseMacAddressQueryDialog.open()
                            }
                        }
                    }
                }

                SectionHeading {
                    section: "Wake On Lan über Internet"
                }

                Row {
                    width: parent.width

                    Label {
                        height: enableWakeOnWan.height
                        verticalAlignment: Text.AlignVCenter
                        font {
                            pixelSize: UIConstants.LIST_TILE_SIZE
                            bold: true
                        }

                        color: (theme.inverted ? UIConstants.LIST_TITLE_COLOR_INVERTED : UIConstants.LIST_TITLE_COLOR)

                        text: qsTr("Wake On Lan über Internet")
                    }

                    Switch {
                        id: enableWakeOnWan
                        anchors.right: parent.right
                        anchors.rightMargin: UIConstants.MARGIN_XLARGE
                    }
                }

                Column {
                    id: wowFieldsWrapper

                    enabled: enableWakeOnWan.checked

                    spacing: UIConstants.DEFAULT_MARGIN
                    opacity: (enableWakeOnWan.checked ? 1 : 0.3)
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    SectionHeading {
                        section: qsTr("Regel")
                    }

                    ButtonColumn {
                        anchors {
                            left: parent.left
                            right: parent.right
                        }

                        Button {
                            text: "Immer über Internet senden"
                        }

                        Button {
                            text: "Bei mobiler Datenverbindung"
                        }

                        Button {
                            text: "Nur, wenn nicht in folgenden Netzen"
                        }
                    }

                    SectionHeading {
                        section: qsTr("WLAN")
                    }

                    Row {
                        width: parent.width
                        Column {
                            spacing: UIConstants.DEFAULT_MARGIN

                            anchors {
                                left: parent.left
                                right: parent.right
                            }

                            Label {
                                anchors {
                                    left: parent.left
                                    right: parent.right
                                }

                                platformStyle: LabelStyle {
                                    fontFamily: "Nokia Pure Text Light"
                                    fontPixelSize: UIConstants.FONT_SMALL
                                }
                                wrapMode: Text.WordWrap
                                color: !theme.inverted ? UIConstants.COLOR_SECONDARY_FOREGROUND : UIConstants.COLOR_INVERTED_SECONDARY_FOREGROUND

                                text: qsTr("Das magische Paket wird über das Internet gesendet, wenn sich das Gerät <b>nicht</b> in dem angegebenen WLAN befindet.")
                                textFormat: Text.RichText
                            }

                            ExtendedListItem {
                                id: wifiListSelector
                                title: "Netze"
                                subTitle: "Netze wählen..."

                                onClicked: wlanSelector.open()
                            }
                        }
                    }
                }


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

    MultiSelectionDialog {
        id: wlanSelector
        model: wifiList

        acceptButtonText: qsTr("Übernehmen")
        titleText: qsTr("Netze wählen")

        onSelectedIndexesChanged: {
            if (wlanSelector.selectedIndexes.length > 0) {
                var s = "Test.. ";

                for (var i=0; i<wlanSelector.selectedIndexes.length; i++) {
                    s += wifiList[i];

                    if (i < wlanSelector.selectedIndexes.length -1)
                        s += ", "
                }

                wifiListSelector.subTitle = s;
            } else {
                wifiListSelector.subTitle = "Netze wählen..."
            }


        }
    }

    QueryDialog {
        id: parseMacAddressQueryDialog
        icon: "image://theme/icon-l-search" //"../images/globe.png"
        titleText: qsTr("MAC-Adresse einfügen")
        message: qsTr("Kopiere die MAC-Adresse aus einer anderen Anwendung und drücke 'Einfügen'")
        acceptButtonText: qsTr("Einfügen")
        rejectButtonText: qsTr("Abbrechen")

        onAccepted: {
            var valid = macAdressButtonRow.parseMac(clipboard.getText());

            if (valid) {
                infoBanner.text = qsTr("MAC-Adresse aus der Zwischenablage übernommen")
                infoBanner.iconSource = "../images/success.png"
            } else {
                infoBanner.text = qsTr("Keine gültige MAC-Adresse in der Zwischenablage gefunden")
                infoBanner.iconSource = "../images/error.png"
            }

            infoBanner.show()
        }
    }

    Component.onCompleted: {
        wifiModel.deleteLater()
    }
}

