// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1

Item {
    property string title: ""
    property color fontColor: "#FFF"

    property bool clickable: false
    property bool useSheetHeaderBackground: false

    property QtObject sheetHeaderPlatformStyle: SheetStyle {}

    signal pressed()
    signal pressAndHold()

    id: root

    height: 72
    width: parent.width

    Image {
        id: backgroundImage
        visible: !useSheetHeaderBackground
        source: "image://theme/" + theme.colorString + "meegotouch-view-header-fixed" + (mouse.pressed ? "-pressed" : "")
        anchors.fill: parent
    }

    BorderImage {
        id: backgroundBorderImage
        visible: useSheetHeaderBackground
        source: "image://theme/meegotouch-sheet-header" + (theme.inverted ? "-inverted" : "") + "-background" + (mouse.pressed ? "-pressed" : "")
        anchors.fill: parent

        border {
            left: sheetHeaderPlatformStyle.headerBackgroundMarginLeft
            right: sheetHeaderPlatformStyle.headerBackgroundMarginRight
            top: sheetHeaderPlatformStyle.headerBackgroundMarginTop
            bottom: sheetHeaderPlatformStyle.headerBackgroundMarginBottom
        }
    }

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

        anchors.fill: parent

        onPressed: {
            root.pressed();
        }

        onPressAndHold: {
            root.pressAndHold();
        }
    }
}

//Image {
//    property string title: ""
//    property color fontColor: "#FFF"

//    property bool clickable: false
//    property bool useSheetHeaderBackground: false

//    signal pressed()
//    signal pressAndHold()

//    id: root

//    height: 72
//    width: parent.width
//    //source: "image://theme/" + theme.colorString + "meegotouch-view-header-fixed" + (mouse.pressed ? "-pressed" : "")
//    source: useSheetHeaderBackground ?
//                    "image://theme/meegotouch-sheet-header" + (theme.inverted ? "-inverted" : "") + "-background" + (mouse.pressed ? "-pressed" : "")
//                :   "image://theme/" + theme.colorString + "meegotouch-view-header-fixed" + (mouse.pressed ? "-pressed" : "")
//    z: 1

//    Label {
//        id: header
//        anchors {
//            verticalCenter: parent.verticalCenter
//            left: parent.left
//            leftMargin: 16
//        }
//        platformStyle: LabelStyle {
//            fontFamily: "Nokia Pure Text Light"
//            fontPixelSize: 32
//        }

//        color: root.fontColor
//        text: (root.title != "" ? root.title : "Page Title")
//    }

//    MouseArea {
//        id: mouse
//        enabled: root.clickable

//        anchors.fill: parent

//        onPressed: {
//            root.pressed();
//        }

//        onPressAndHold: {
//            root.pressAndHold();
//        }
//    }
//}
