// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1

Item {
    id: root

    property string text: ""

    opacity: 0.4

    Label {
        anchors.fill: parent

        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 64
            inverted: theme.inverted
        }

        text: root.text
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}


