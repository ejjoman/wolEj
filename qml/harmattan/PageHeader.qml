// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1

Image {
    property string title: ""
    property color fontColor: "#FFF"

    property bool clickable: false

    signal pressed()
    signal pressAndHold()

    id: root

    height: 72
    width: parent.width
    source: "image://theme/" + theme.colorString + "meegotouch-view-header-fixed" + (mouse.pressed ? "-pressed" : "")
    z: 1

    Label {
        id: header
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 16
        }
        platformStyle: LabelStyle {
            fontFamily: "Nokia Pure Text Light"
            fontPixelSize: 32
        }

        color: root.fontColor
        text: (root.title != "" ? root.title : "Page Title")
    }

    MouseArea {
        id: mouse
        enabled: root.clickable

        onPressed: {
            root.pressed();
        }

        onPressAndHold: {
            root.pressAndHold();
        }
    }
}
