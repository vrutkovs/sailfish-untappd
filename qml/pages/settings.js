.import QtQuick.LocalStorage 2.0 as LS

var initializeHasRun = false;

function getDatabase() {
    var db = LS.LocalStorage.openDatabaseSync("Untappd", "1.0", "StorageDatabase", 10000);
    if (initializeHasRun) return db;

    db.transaction(function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)");
    });

    return db;
}

function set(key, value) {
    var db = getDatabase();
    var res = false;
    db.transaction(function(tx) {
        var query = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?, ?);', [key, JSON.stringify(value)]);
        res = query.rowsAffected > 0;
    });
    return res;
}

function get(key) {
    var db = getDatabase();
    var res;
    db.transaction(function(tx) {
        var query = tx.executeSql('SELECT value FROM settings WHERE setting = ?;', [key]);
        if (query.rows.length > 0) res = JSON.parse(query.rows.item(0).value);
        else res = false;
    });
    return res;
}
