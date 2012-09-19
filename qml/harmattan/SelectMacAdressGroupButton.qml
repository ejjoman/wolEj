// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1

Button {
    id: root
    text: "" //(root.groupIndex + 1).toString()

    property int groupIndex: 0
    property ListModel model: null

    property bool validSelection: false
    property string groupValue: ""

    property string emptyGroupPlaceholder: "..."

    function reset() {
        root.groupValue = "";
    }

    onClicked: {
        macAdressGroupTumblerDialog.open();
    }

    onGroupValueChanged: {
        if (groupValue === "") {
            root.text = root.emptyGroupPlaceholder // (root.groupIndex + 1).toString()

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
        titleText: qsTr("Gruppe %1 der MAC-Adresse").arg((root.groupIndex + 1).toString())
        columns: [
            TumblerColumn {
                id: hexDigit1
                items: root.model
                label: qsTr("1. Stelle")
            },

            TumblerColumn {
                id: hexDigit2
                items: root.model
                label: qsTr("2. Stelle")
            }
        ]

        onAccepted: {
            var hex1 = root.model.get(hexDigit1.selectedIndex).value;
            var hex2 = root.model.get(hexDigit2.selectedIndex).value;

            root.groupValue = hex1 + hex2;
        }
    }

    Component.onCompleted: {
        if (root.text === "")
            root.text = root.emptyGroupPlaceholder
    }
}
