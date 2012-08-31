// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
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

        Image {
            anchors {
                rightMargin: UIConstants.MARGIN_XLARGE
                right: parent.right
                verticalCenter: parent.verticalCenter
            }

            source: "../images/btn_donate_LG.gif"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KKQX7F8QMANK8")
                }
            }
        }
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
            anchors.topMargin: 40
            spacing: 40 //UIConstants.DEFAULT_MARGIN

            anchors.fill: parent

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Image {
                    source: "../../resources/wakeonlan.png"
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

                    text: "Info:"
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

                    text: "Wake On Lan ist eine Anwendung, welche es ermöglicht, LAN-Clients mit einem Magischen Paket zu starten.<br/>Copyright (C) 2012"
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

                    text: "Projektseite:"
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

                    text: "https://github.com/ejjoman/WakeOnLan-Harmattan"
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: flickable
    }
}
