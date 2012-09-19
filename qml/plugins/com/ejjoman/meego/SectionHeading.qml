// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import "uiconstants.js" as UIConstants

Item {
    width: parent.width
    height: 40 // TODO UIConstants

    property alias section: headerLabel.text

    Text {
        id: headerLabel
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 8 // IMPROVE UIConstants
        anchors.bottomMargin: 2 // IMPROVE UIConstants
        font.bold: true
        font.pointSize: 14 // 18 // IMPROVE UIConstants

        color: theme.inverted ? UIConstants.COLOR_INVERTED_SECONDARY_FOREGROUND : UIConstants.COLOR_SECONDARY_FOREGROUND
    }
    Image {
        anchors.right: headerLabel.left
        anchors.left: parent.left
        anchors.verticalCenter: headerLabel.verticalCenter
        anchors.rightMargin: 24 // IMPROVE UIConstants
        source: "image://theme/meegotouch-groupheader" + (theme.inverted ? "-inverted" : "") + "-background"
    }
}
