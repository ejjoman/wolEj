// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

ListModel {
    id: root

    function fillModel() {
        for (var i=0; i<16; i++) {
            for (var j=0; j<16; j++) {
                root.append({'value': i.toString(16).toUpperCase() + j.toString(16).toUpperCase()})
            }
        }
    }

    Component.onCompleted: {
        //fillModel();
    }
}
