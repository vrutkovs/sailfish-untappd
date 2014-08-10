import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App

Dialog {
  id: checkinPage
  property var beer
  canAccept: checkinText.length <= 140

  SilicaFlickable {
    anchors.fill: parent
    contentHeight: content.height + Theme.paddingLarge

    Column {
        id: col
        spacing: Theme.paddingMedium
        width: parent.width

        DialogHeader {
          acceptText: "Check in"
        }

        Label {
          text: beer.beer.beer_name
          font.pixelSize: Theme.fontSizeLarge
          anchors {
            horizontalCenter: parent.horizontalCenter
          }
        }

        TextArea {
          width: parent.width
          id: checkinText
          height: Math.max(80, implicitHeight)
          errorHighlight: text.length > 140
          placeholderText: "What did you think?"
          label: 140 - text.length
        }

        Slider {
          value: 5
          minimumValue:0
          maximumValue:5
          stepSize: 0.5
          width: parent.width
          valueText: value == 0 ? "No Rating" : value
          label: "Rating"
        }
      }

      VerticalScrollDecorator {}
  }
}
