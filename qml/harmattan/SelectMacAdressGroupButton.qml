// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Button {
    id: root
    text: "xx" //(root.groupIndex + 1).toString()

    property int groupIndex: 0
    property ListModel model: null

    property bool validSelection: false
    property string groupValue: ""

    function reset() {
        root.groupValue = "";
    }

    onClicked: {
        macAdressGroupTumblerDialog.open();
    }

    onGroupValueChanged: {
        if (groupValue === "") {
            root.text = "xx" // (root.groupIndex + 1).toString()

            hexDigit1.selectedIndex = 0
            hexDigit2.selectedIndex = 0

            root.validSelection = false;
        } else {
            root.text = root.groupValue;

            hexDigit1.selectedIndex = getIndexByValue(root.groupValue.charAt(0))
            hexDigit2.selectedIndex = getIndexByValue(root.groupValue.charAt(1))

            root.validSelection = true;
        }


    }

    function getIndexByValue(value) {
        for (var i=0; i<root.model.count; i++)
            if (root.model.get(i).value == value)
                return i;

        return undefined;
    }

    TumblerDialog {
        id: macAdressGroupTumblerDialog
        titleText: "Gruppe " + (root.groupIndex + 1).toString() + " der MAC-Adresse"
        columns: [
            TumblerColumn {
                id: hexDigit1
                items: root.model
                label: "1. Stelle"
            },

            TumblerColumn {
                id: hexDigit2
                items: root.model
                label: "2. Stelle"
            }
        ]

        onAccepted: {
            var hex1 = root.model.get(hexDigit1.selectedIndex).value;
            var hex2 = root.model.get(hexDigit2.selectedIndex).value;

            root.groupValue = hex1 + hex2;
        }
    }
}
