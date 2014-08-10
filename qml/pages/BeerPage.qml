import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
  id: page
  property var beer
  SilicaFlickable {
    anchors.fill: parent
    contentHeight: content.height + Theme.paddingLarge

    VerticalScrollDecorator {}

    Item {
      id: content
      width: parent.width


      PageHeader {
        title: ""
        id: header
      }

      Image {
        source: beer.beer.beer_label
        id: beerlabel
        width: 150
        height: 150
        anchors {
          left: parent.left
          top: header.bottom
          topMargin: Theme.paddingMedium
          leftMargin: Theme.paddingMedium
        }
      }

      Label {
        text: beer.beer.beer_name
        font.pixelSize: Theme.fontSizeLarge
        id: beername
        anchors {
          left: beerlabel.right
          top: header.bottom
          topMargin: Theme.paddingMedium
          leftMargin: Theme.paddingMedium
          right: parent.right
          rightMargin: Theme.paddingMedium
        }
      }

      Image {
        source: beer.brewery.brewery_label
        id: brewerylabel
        width: 50
        height: 50
        anchors {
          right: parent.right
          top: beername.bottom
          topMargin: Theme.paddingMedium
          rightMargin: Theme.paddingMedium
        }
      }
      Label {
        text: beer.brewery.brewery_name
        color: Theme.primaryColor
        id: breweryname
        font.pixelSize: Theme.fontSizeMedium
        truncationMode: TruncationMode.Elide
        anchors {
          top: beername.bottom
          topMargin: Theme.paddingMedium
          right: brewerylabel.left
          rightMargin: Theme.paddingMedium
          left: beerlabel.right
          leftMargin: Theme.paddingMedium
        }
      }

      Label {
        text: beer.beer.beer_style
        color: Theme.secondaryColor
        id: beerstyle
        font.pixelSize: Theme.fontSizeSmall
        anchors {
          top: breweryname.bottom
          left: beerlabel.right
          leftMargin: Theme.paddingMedium
        }
      }

      Label {
        text: beer.beer.beer_description
        color: Theme.secondaryColor
        id: beerdesc
        font.pixelSize: Theme.fontSizeExtraSmall
        wrapMode: Text.WordWrap
        truncationMode: TruncationMode.Fade
        maximumLineCount: 4
        visible: beer.beer.beer_description.length > 0
        anchors {
          top: beerlabel.bottom
          topMargin: Theme.paddingMedium
          left: parent.left
          right: parent.right
          leftMargin: Theme.paddingMedium
          rightMargin: Theme.paddingMedium
        }
      }

      Button {
        text: "Check in"
        onClicked: pageStack.push(Qt.resolvedUrl("CheckinPage.qml"), { beer: beer }, PageStackAction.Animated)
        anchors {
          top: beerdesc.bottom
          topMargin: Theme.paddingMedium
          horizontalCenter: parent.horizontalCenter
        }
      }
    }
  }
}
