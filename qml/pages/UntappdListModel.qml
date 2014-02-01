import QtQuick 2.0

Item {
    property string source: ""
    property string json: ""

    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    onSourceChanged: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE)
                json = xhr.responseText;
        }
        xhr.send();
    }

    onJsonChanged: updateJSONModel()

    function updateJSONModel() {
        jsonModel.clear();

        if ( json == "" )
            return;

        var objectArray = parseJSONString(json);
        for ( var key in objectArray ) {
            var jo = objectArray[key];
            jsonModel.append( jo );
        }
    }

    function parseJSONString(jsonString) {
        var response = JSON.parse(jsonString);
        return response.response.checkins.items;
    }
}
