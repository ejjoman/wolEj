import QtQuick 1.1
import com.nokia.meego 1.1
import "uiconstants.js" as UI

Item {
    id: listItem

    signal clicked
    signal pressAndHold

    property alias pressed: mouseArea.pressed

    property int titleSize: UI.LIST_TILE_SIZE
    property int titleWeight: Font.Bold
    property color titleColor: theme.inverted ? UI.LIST_TITLE_COLOR_INVERTED : UI.LIST_TITLE_COLOR

    property int subtitleSize: UI.LIST_SUBTILE_SIZE
    property int subtitleWeight: Font.Light
    property color subtitleColor: theme.inverted ? UI.LIST_SUBTITLE_COLOR_INVERTED : UI.LIST_SUBTITLE_COLOR

    property string iconSource: ""
    property string title: ""
    property string subTitle: ""

    height: UI.LIST_ITEM_HEIGHT
    width: parent.width

    BorderImage {
        id: background
        anchors.fill: parent
        // Fill page porders
        anchors.leftMargin: -UI.MARGIN_XLARGE
        anchors.rightMargin: -UI.MARGIN_XLARGE
        visible: mouseArea.pressed
        source: "image://theme/meegotouch-list" + (theme.inverted ? "-inverted" : "") +"-background-pressed-center"
    }

    Row {
        anchors.fill: parent
        spacing: UI.LIST_ITEM_SPACING

        anchors.leftMargin: UI.MARGIN_XLARGE
        anchors.rightMargin: UI.MARGIN_XLARGE

        Image {
            anchors.verticalCenter: parent.verticalCenter
            visible: listItem.iconSource ? true : false
            width: UI.LIST_ICON_SIZE
            height: UI.LIST_ICON_SIZE
            source: listItem.iconSource ? listItem.iconSource : ""

        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Label {
                id: mainText
                text: listItem.title
                font.weight: listItem.titleWeight
                font.pixelSize: listItem.titleSize
                color: listItem.titleColor
            }

            Label {
                id: subText
                text: listItem.subTitle || ""
                font.weight: listItem.subtitleWeight
                font.pixelSize: listItem.subtitleSize
                color: listItem.subtitleColor

                visible: listItem.subTitle != ""
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: listItem.clicked()
        onPressAndHold: listItem.pressAndHold()
    }
}
