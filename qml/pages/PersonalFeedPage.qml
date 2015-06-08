import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App


Page {
    id: page
    backNavigation: false

    SilicaListView {
      PullDownMenu {
        id: pullDownMenu
        MenuItem {
          text: "Drink up!"
          onClicked: pageStack.push(Qt.resolvedUrl("SearchPage.qml"))
        }
      }

      id: listView
      spacing: Theme.paddingLarge

      Component.onCompleted: {
        App.api("/v4/user/checkins/", function(err, data) {
          data.checkins.items.forEach(function(checkin) {
            // QML doesn't like checkin.venue
            // Lets just store things we're interested in
            var venue = Object();
            if (checkin.venue.venue_name) {
                venue.venue_name = checkin.venue.venue_name;
            }
            checkin.venue = venue;
            lmodel.append(checkin);
          })
        });
      }

      ListModel { id: lmodel }

      model: lmodel

      anchors.fill: parent
      header: PageHeader {
        title: "Recent checkins"
      }

      VerticalScrollDecorator {}

      delegate: BackgroundItem {
        id: delegate
        height: 120
        contentHeight: 100
        width: parent.width - 2*Theme.paddingLarge
        x: Theme.paddingLarge

        Image {
          source: model.user.user_avatar
          id: beerlabel
          width: 80
          height: 80
          anchors {
            left: parent.left
            top: parent.top
            topMargin: Theme.paddingSmall
          }
        }

        Label {
          id: username
          text: {
            var name = model.user.first_name + ' ' + model.user.last_name;
            if (model.venue.venue_name) {
                name = name + ' at ' + model.venue.venue_name;
            }
            return name;
          }

          font.pixelSize: Theme.fontSizeExtraSmall
          font.bold: true
          truncationMode: TruncationMode.Fade
          anchors {
            top: parent.top
            left: beerlabel.right
            leftMargin: Theme.paddingMedium
            right: parent.right
          }
        }

        Label {
          id: beerTitle
          font.pixelSize: Theme.fontSizeSmall
          text: model.beer.beer_name
          wrapMode: Text.WordWrap
          maximumLineCount: 2
          color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
          anchors {
            left: beerlabel.right
            right: rating.left
            top: username.bottom
            leftMargin: Theme.paddingMedium
          }
        }

        Label {
          id: rating
          font.pixelSize: Theme.fontSizeSmall
          font.bold: true
          text: model.rating_score
          anchors {
            top: beerlabel.verticalCenter
            leftMargin: Theme.paddingSmall
            right: parent.right
          }
        }

        Label {
          id: breweryTitle
          font.pixelSize: Theme.fontSizeExtraSmall
          text: 'by ' + model.brewery.brewery_name
          truncationMode: TruncationMode.Fade
          color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
          anchors {
            left: beerlabel.right
            right: rating.left
            top: beerTitle.bottom
            leftMargin: Theme.paddingMedium
          }
        }
      }

      VerticalScrollDecorator {}
    }
}





