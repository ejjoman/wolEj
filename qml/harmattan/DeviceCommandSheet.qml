// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import com.ejjoman.plugins 1.0

import "../plugins/com/ejjoman/meego" 1.0
import "../plugins/com/ejjoman/meego/uiconstants.js" as UIConstants

ExtendedSheet {
    id: root

    //acceptButtonText: "Hinzufügen"
    rejectButtonText: qsTr("Schließen")

    property int deviceIndex: -1
    property variant device: undefined

    onDeviceIndexChanged: {
        if (root.deviceIndex == -1) {
            root.device = undefined
        } else {
            root.device = devices.get(root.deviceIndex)
            label.text = qsTr("Der Befehl zum Ausführen kann dazu verwendet werden, um das Gerät \"%1\" mithilfe anderer Anwendungen aufzuwecken.<br/><br/>Der Befehl kann beispielsweise:<ul><li>In eigenen Shell-Scripten<br/>oder</li><li>Als Action in der App <a href=\"http://store.ovi.com/content/216122\">ProfileMatic</a></li></ul>verwendet werden.").arg(device.Name)
        }
    }

    InfoBanner {
        id: infoBanner
        text: qsTr("Der Befehl wurde kopiert")
        iconSource: "../images/success.png"
    }

    Clipboard {
        id: clipboard
    }

    contentItem: Item {
        anchors.fill: parent

        Column {
            anchors.fill: parent
            anchors.leftMargin: UIConstants.DEFAULT_MARGIN
            anchors.rightMargin: UIConstants.DEFAULT_MARGIN

            spacing: 40

            Label {
                id: label

                anchors {
                    left: parent.left
                    right: parent.right
                }

                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Befehl kopieren")

                onClicked: {
                    clipboard.setText("/opt/wolEj/bin/wolEj -wake -mac %1 -showbanner -devicename \"%2\"".arg(root.device.MAC).arg(root.device.Name))
                    infoBanner.show()
                }
            }
        }
    }
}
