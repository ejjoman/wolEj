import QtQuick 1.0
import com.nokia.meego 1.1

BorderImage {
    width: parent.width
    height: 2
    source: "image://theme/meegotouch-separator" + (theme.inverted ? "-inverted" : "") + "-background-horizontal"
}
