// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "uiconstants.js" as UIConstants

Column {
    id: root

    property string title: qsTr("Title")
    property bool multilineTitle: false
    property string iconSource



    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    spacing: 0 //UIConstants.DEFAULT_MARGIN
    Item {
        id: titleContents
        anchors.left: parent.left
        anchors.right: parent.right
        height: Math.max(icon.height, titleLabel.paintedHeight);

        Image {
            id: icon
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: root.iconSource ? 64 : 0
            height: root.iconSource ? 64 : 0
            source: root.iconSource
            visible: root.iconSource
        }

        Label {
            id: titleLabel
            anchors.left: icon.right

            anchors.margins: {
                left: icon.visible ? UIConstants.DEFAULT_MARGIN : 0
                right: 0
                top: 0
                bottom: 0
            }

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            color: UIConstants.HEADER_TITLE_COLOR
            text: root.title

            platformStyle: LabelStyle {
                fontFamily: "Nokia Pure Text Light"
                fontPixelSize: 32
            }

            wrapMode: root.multilineTitle ? Text.Wrap : Text.NoWrap
            maximumLineCount: root.multilineTitle ? 2 : 1
            elide: root.multilineTitle ? Text.ElideRight : Text.ElideNone
        }
    }

    Separator {}
}
