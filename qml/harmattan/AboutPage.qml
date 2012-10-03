// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "../plugins/com/ejjoman/meego" 1.0

import "../plugins/com/ejjoman/meego/uiconstants.js" as UIConstants

Page {
    id: root
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    PageHeader {
        id: pageHeader
        useSheetHeaderBackground: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        title: qsTr("Über Wake On Lan")

//        Image {
//            anchors {
//                rightMargin: UIConstants.MARGIN_XLARGE
//                right: parent.right
//                verticalCenter: parent.verticalCenter
//            }

//            source: "../images/btn_donate_LG.gif"

//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KKQX7F8QMANK8")
//                }
//            }
//        }
    }

    Flickable {
        id: flickable
        clip: true
        contentHeight: wrapperCol.childrenRect.height

        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Column {
            id: wrapperCol
            anchors.leftMargin: UIConstants.DEFAULT_MARGIN
            anchors.rightMargin: UIConstants.DEFAULT_MARGIN
            //anchors.topMargin: 40
            spacing: 40 //UIConstants.DEFAULT_MARGIN

            //anchors.fill: parent

            anchors.left: parent.left
            anchors.right: parent.right

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Image {
                    source: "../../resources/wolEj.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    smooth: true
                    width: 150
                    height: 150
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter

                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                    }

                    text: qsTr("Version %1").arg("0.0.1")
                }
            }

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Label {
                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                        textColor: "#CCC"
                    }

                    text: qsTr("Info:")
                }

                Label {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                    }
                    wrapMode: Text.WordWrap

                    text: qsTr("<p>Wake On Lan ist ein Tool mit welchem Sie Ihre LAN-Clients (PC, Server, Media Center, ...) einfach aufwecken können.<br/>Es erlaubt Ihnen, eine unlimitierte Anzahl von LAN-Clients zu konfigurieren. Außerdem können Sie konfigurierte Clients direkt von Ihrem Start-Bildschirm aus aufwecken.</p><p>Copyright © 2012 Michael Neufing</p>")
                }
            }

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Label {
                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                        textColor: "#CCC"
                    }

                    text: qsTr("Projektseite:")
                }

                Label {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                    }

                    text: qsTr("<p>Weitere Informationen und den Quelltext der Anwendung finden Sie unter:</p>\
                          <p><a href=\"https://github.com/ejjoman/wolEj\">https://github.com/ejjoman/wolEj</a></p>")
                    onLinkActivated: Qt.openUrlExternally(link);
                }
            }

            Separator {}

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Label {
                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                        textColor: "#CCC"
                    }

                    text: qsTr("Lizenz:")
                }

                Label {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    platformStyle: LabelStyle {
                        fontFamily: "Nokia Pure Text"
                        fontPixelSize: 24
                    }
                    wrapMode: Text.WordWrap
                    text: qsTr("AboutPage.LicenseText")

                    onLinkActivated: Qt.openUrlExternally(link);
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
