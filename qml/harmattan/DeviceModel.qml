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
                                                       MAC: rs.rows.item(i).MAC,
                                                       hasStarter: hasStarter(rs.rows.item(i).ID)
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
//        __db().transaction(
//                    function(tx) {
//                        __ensureTables(tx);
//                        tx.executeSql('DELETE FROM Devices');
//                    });

        for (var i=0; i<count; i++) {
            var item = get(i);
            deleteDevice(item.id);
        }

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

        removeStarter(id);

        load();
    }

    function getById(id){
        for (var i=0; i < deviceModel.count; i++) {
            var item = deviceModel.get(i);

            if (item.id === id)
                return item;
        }

        return undefined;
    }

    function getSelectedItem() {
        if (deviceModel.selectedIndex === -1)
            return null;

        return deviceModel.get(deviceModel.selectedIndex)
    }

    function hasStarter(id) {
        return fileSystem.fileExists("/home/user/.local/share/applications/wakeonlan_harmattan_" + id + ".desktop")
    }

    function removeStarter(id) {
        if (hasStarter(id)) {
            return fileSystem.deleteFile("/home/user/.local/share/applications/wakeonlan_harmattan_" + id + ".desktop")
        } else {
            return false;
        }
    }

    function addStarter(id) {
        if (hasStarter(id)) {
            return true;
        } else {
            var fileContents = fileSystem.readFromFile("/opt/wakeonlan/resources/mask.desktop")

            fileContents = fileContents.replace(/\$MAC/g, deviceModel.getById(id).MAC);
            fileContents = fileContents.replace(/\$NAME/g, deviceModel.getById(id).Name);

            return fileSystem.writeToFile("/home/user/.local/share/applications/wakeonlan_harmattan_" + id + ".desktop", fileContents)
        }
    }

    Component.onCompleted: load()
}
