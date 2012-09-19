// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

import "DatabaseMigrator.js" as M

ListModel {
    id: root

    property int selectedIndex: -1

    function __db() {
        var db = openDatabaseSync("wolEjDB", "", "wolEj Database", 1000000)

        var migrator = new M.Migrator(db);

        migrator.migration(1, function(tx){
            var createDevicesTable = 'CREATE TABLE IF NOT EXISTS "Devices" ("ID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "Name" TEXT NOT NULL, "MAC" TEXT NOT NULL)';
            tx.executeSql(createDevicesTable);

            console.log("Database: Magrated to Version 1.")
        });

        migrator.migration(2, function(tx){
            tx.executeSql('ALTER TABLE Devices ADD COLUMN "Ordering" INTEGER NOT NULL DEFAULT 0');
            tx.executeSql('ALTER TABLE Devices ADD COLUMN "WifiName" TEXT');
            tx.executeSql('ALTER TABLE Devices ADD COLUMN "WowHost" TEXT');
            tx.executeSql('ALTER TABLE Devices ADD COLUMN "WowPort" INTEGER');

            console.log("Database: Magrated to Version 2.")
        });

        migrator.doIt();

        return db;
    }

    function saveOrdering() {
        __db().transaction(function(tx) {
            for (var i=0; i<root.count; i++) {
                var item = root.get(i);
                tx.executeSql("UPDATE Devices SET Ordering=? WHERE ID=?", [i, item.id]);
            }
        });
    }

    function moveUp(item) {
        var index = item.index;

        if (index > 0)
            root.move(index, index-1, 1);

        root.saveOrdering();
    }

    function moveDown(item) {
        var index = item.index;

        if (index < root.count - 1)
            root.move(index, index+1, 1);

        root.saveOrdering();
    }

    function load() {
        __db().transaction(function(tx) {
            var rs = tx.executeSql("SELECT * FROM Devices ORDER BY Ordering");
            root.clear();

            if (rs.rows.length > 0)
                for (var i=0; i<rs.rows.length; i++)
                    root.append({
                                    id: rs.rows.item(i).ID,
                                    Name: rs.rows.item(i).Name,
                                    MAC: rs.rows.item(i).MAC,
                                    hasStarter: hasStarter(rs.rows.item(i).ID),
                                    Ordering: rs.rows.item(i).Ordering,
                                    index: i
                                })

        });
    }

    function deviceExists(mac) {
        for (var i=0; i<root.count; i++) {
            var item = root.get(i);
            if (item.MAC === mac)
                return true;
        }

        return false;
    }

    function addDevice(deviceName, mac) {
        if (!deviceExists(mac)) {
            __db().transaction(function(tx) {
                tx.executeSql('INSERT INTO Devices (Name, MAC) VALUES (?, ?)', [deviceName, mac]);
            });

            load();
        }
    }

    function clearDevices() {
        for (var i=0; i<count; i++) {
            var item = get(i);
            removeStarter(item.id);
        }

        __db().transaction(function(tx) {
            tx.executeSql('DELETE FROM Devices');
        });

        load();
    }

    function deleteDevice(id) {
        __db().transaction(function(tx) {
            tx.executeSql('DELETE FROM Devices WHERE ID=?', [id]);
        });

        if (root.selectedIndex === id)
            root.selectedIndex = -1;

        removeStarter(id);

        load();
    }

    function getById(id){
        for (var i=0; i < root.count; i++) {
            var item = root.get(i);

            if (item.id === id)
                return item;
        }

        return undefined;
    }

    function getSelectedItem() {
        if (root.selectedIndex === -1)
            return null;

        return root.get(root.selectedIndex)
    }

    function hasStarter(id) {
        return fileSystem.fileExists("/home/user/.local/share/applications/wolEj_" + id + ".desktop")
    }

    function removeStarter(id) {
        if (hasStarter(id)) {
            return fileSystem.deleteFile("/home/user/.local/share/applications/wolEj_" + id + ".desktop")
        } else {
            return false;
        }
    }

    function addStarter(id) {
        if (hasStarter(id)) {
            return true;
        } else {
            var fileContents = fileSystem.readFromFile("/opt/wolEj/resources/mask.desktop")

            fileContents = fileContents.replace(/\$MAC/g, root.getById(id).MAC);
            fileContents = fileContents.replace(/\$NAME/g, root.getById(id).Name);

            return fileSystem.writeToFile("/home/user/.local/share/applications/wolEj_" + id + ".desktop", fileContents)
        }
    }

    Component.onCompleted: root.load()
}
