// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

ListModel {
    id: deviceModel

    property int selectedIndex: -1

    function __db() {
        return openDatabaseSync("wolEjDB", "1.0", "wolEj Database", 1000000)
    }

    function __ensureTables(tx) {
        var createDevicesTable = 'CREATE TABLE IF NOT EXISTS "Devices" ("ID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "Name" TEXT NOT NULL, "MAC" TEXT NOT NULL)';
        tx.executeSql(createDevicesTable);
    }

    function load() {
        __db().transaction(
                    function(tx) {
                        __ensureTables(tx);

                        var rs = tx.executeSql("SELECT * FROM Devices");
                        deviceModel.clear();

                        if (rs.rows.length > 0)
                            for (var i=0; i<rs.rows.length; i++)
                                deviceModel.append({
                                                       id: rs.rows.item(i).ID,
                                                       Name: rs.rows.item(i).Name,
                                                       MAC: rs.rows.item(i).MAC
                                                   })

                    });
    }

    function deviceExists(mac) {
        for (var i=0; i<deviceModel.count; i++) {
            var item = deviceModel.get(i);
            if (item.MAC === mac)
                return true;
        }

        return false;
    }

    function addDevice(deviceName, mac) {
        if (!deviceExists(mac)) {
            __db().transaction(
                        function(tx) {
                            __ensureTables(tx);
                            tx.executeSql('INSERT INTO Devices (Name, MAC) VALUES (?, ?)', [deviceName, mac]);
                        });

            load();
        }
    }

    function clearDevices() {
        __db().transaction(
                    function(tx) {
                        __ensureTables(tx);
                        tx.executeSql('DELETE FROM Devices');
                    });

        load();
    }

    function deleteDevice(id) {
        __db().transaction(
                    function(tx) {
                        __ensureTables(tx);
                        tx.executeSql('DELETE FROM Devices WHERE ID=?', [id]);
                    });

        if (deviceModel.selectedIndex === id)
            deviceModel.selectedIndex = -1;

        load();
    }

    function getSelectedItem() {
        if (deviceModel.selectedIndex === -1)
            return null;

        return deviceModel.get(deviceModel.selectedIndex)
    }

    Component.onCompleted: load()
}
