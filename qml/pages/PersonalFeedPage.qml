import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    onStatusChanged: {
      if (status == PageStatus.Active && !Untappd.isLoggedIn()) {
        console.log("pushing login page", Untappd.isLoggedIn())
        pageStack.push(Qt.resolvedUrl("FirstPage.qml"))
      }
    }

    SilicaListView {
        id: listView

        /*UntappdListModel {
            id: ulistmodel
            source: "http://api.untappd.com/v4/thepub?client_id=7E07FC9AC3B3866F4F620819996F262F087EAC92&client_secret=8CE5E863B1CC5C9B69820BF39717302135582D9A"
        }*/

        ListModel {
          id: lmodel
          ListElement {
            title: "Placeholder"
          }
        }

        model: lmodel

        anchors.fill: parent
        header: PageHeader {
            title: "Untappd"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: model.title
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}





