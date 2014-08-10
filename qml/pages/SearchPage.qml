import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App
import "debounce.js" as Db

Page {
  id: searchPage

  property var retrieveSearchResults: function(query) {
    listModel.clear()
    App.api("/v4/search/beer", { q: query, sort: 'count' }, function(err, data) {
      data.beers.items.forEach(function(beer) {
        listModel.append(beer);
      })
    });
  }

  SilicaListView {
      anchors.fill: parent
      currentIndex: -1 // otherwise currentItem will steal focus
      width: parent.width

      header:  Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
          title: "Drink up!"
        }

        SearchField {
          id: searchField
          width: parent.width

          EnterKey.onClicked: {
            retrieveSearchResults(searchField.text);
          }
        }
      }

      model: ListModel { id: listModel }
      delegate: BackgroundItem {
        id: delegate
        height: 90
        contentHeight: 90

        Label {
          id: beerName
          text: model.beer.beer_name

          font.pixelSize: Theme.fontSizeMedium
          font.bold: true
          truncationMode: TruncationMode.Elide
          anchors {
            top: parent.top
            topMargin: 5
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: abvPercent.left
            rightMargin: Theme.paddingMedium
          }
        }

        Label {
          id: abvPercent
          text: model.beer.beer_abv + "%"
          font.pixelSize: Theme.fontSizeSmall
          anchors {
            top: parent.top
            right: parent.right
            rightMargin: Theme.paddingLarge
          }
        }

        Label {
          id: brewery
          text: model.brewery.brewery_name
          font.pixelSize: Theme.fontSizeExtraSmall
          truncationMode: TruncationMode.Elide
          anchors {
            top: beerName.bottom
            left: parent.left
            leftMargin: Theme.paddingLarge
            right: parent.right
          }
        }

        onClicked: pageStack.push(Qt.resolvedUrl("BeerPage.qml"), { beer: model }, PageStackAction.Animated)
      }

      VerticalScrollDecorator {}
  }
}
