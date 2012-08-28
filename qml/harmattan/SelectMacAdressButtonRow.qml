// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import "../plugins/com/ejjoman/meego" 1.0

ButtonRow {
    id: root
    exclusive: false

    signal openParseMacAddressQueryDialog

    property bool validSelection:
        group1.validSelection &&
        group2.validSelection &&
        group3.validSelection &&
        group4.validSelection &&
        group5.validSelection &&
        group6.validSelection

    property bool showParseMacAddressButton: false
    property string macGroupSeparator: ":"
    property string selectedMacAddress: ''

    function reset() {
        for (var i=0; i<groupButtons.length; i++)
            groupButtons[i].reset();
    }

    function parseMac(mac) {
        if (!isValidMac(mac))
            return false;

        var newMac = new String(mac);

        var groups = newMac.split(root.macGroupSeparator);

        for (var i=0; i<groups.length; i++) {
            var groupButton = root.groupButtons[i];
            groupButton.groupValue = getUpperCaseString(groups[i]);
        }

        return true;
    }

    function getUpperCaseString(str) {
        var oldString = new String(str);
        var newString = new String();

        for (var i=0; i<oldString.length; i++) {
            newString += oldString.charAt(i).toUpperCase();
        }

        return newString;
    }

    function isValidMac(mac) {
        var newMac = new String(mac);
        newMac = newMac.trim().replace(new RegExp(root.macGroupSeparator, "gi"), '');

        if (newMac.length != 12)
            return false;

        for (var i=0; i<newMac.length; i++) {
            if (isNaN(parseInt(newMac.charAt(i), 16)))
                return false;
        }

        return true;
    }

    function updateSelectedMacAddress() {
        if (!root.validSelection)
            return;

        var groups = new Array();

        for (var i=0; i<root.groupButtons.length; i++)
            groups.push(root.groupButtons[i].groupValue)

        root.selectedMacAddress = groups.join(root.macGroupSeparator)
    }

    SelectMacAdressGroupButton {
        id: group1
        objectName: "group1"
        groupIndex: 0
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    SelectMacAdressGroupButton {
        id: group2
        objectName: "group2"
        groupIndex: 1
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    SelectMacAdressGroupButton {
        id: group3
        objectName: "group3"
        groupIndex: 2
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    SelectMacAdressGroupButton {
        id: group4
        objectName: "group4"
        groupIndex: 3
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    SelectMacAdressGroupButton {
        id: group5
        objectName: "group5"
        groupIndex: 4
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    SelectMacAdressGroupButton {
        id: group6
        objectName: "group6"
        groupIndex: 5
        model: hexDigits
        onGroupValueChanged: root.updateSelectedMacAddress()
    }

    property variant groupButtons: [group1, group2, group3, group4, group5, group6]

    Button {
        visible: root.showParseMacAddressButton
        text: "Einfügen"
        onClicked: {
            root.openParseMacAddressQueryDialog()
        }
    }

    ListModel {
        id: hexDigits

        Component.onCompleted: {
            for (var i=0; i<16; i++)
                append({'value': i.toString(16).toUpperCase()});
        }
    }
}



