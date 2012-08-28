// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

BorderImage {
    height: parent.height
    width: 2
    source: "image://theme/meegotouch-separator" + (theme.inverted ? "-inverted" : "") + "-background-vertical"
}
