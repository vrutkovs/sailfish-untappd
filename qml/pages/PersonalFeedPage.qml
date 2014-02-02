import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App


Page {
    id: page
    backNavigation: false

    SilicaListView {
        id: listView

        /*UntappdListModel {
            id: ulistmodel
            source: "http://api.untappd.com/v4/thepub?client_id=7E07FC9AC3B3866F4F620819996F262F087EAC92&client_secret=8CE5E863B1CC5C9B69820BF39717302135582D9A"
        }*/

        Component.onCompleted: {
          App.api("/v4/checkin/recent", function(err, data) {
            data.checkins.items.forEach(function(checkin) {
              lmodel.append(checkin);
            })
          });
        }

        ListModel { id: lmodel }

        model: lmodel

        anchors.fill: parent
        header: PageHeader {
            title: "Untappd"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: model.beer.beer_name
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}





