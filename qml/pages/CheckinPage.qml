import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App

Dialog {
  id: checkinPage
  property var beer

  SilicaListView {
      anchors.fill: parent
      currentIndex: -1 // otherwise currentItem will steal focus
      header:  Column {
        id: col
        spacing: Theme.paddingMedium
        width: parent.width

        PageHeader {
          title: "Check in"
        }

        Label {
          text: beer.beer.beer_name
          font.pixelSize: Theme.fontSizeLarge
          horizontalAlignment: Label.AlignHCenter
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

        TextArea {
          width: parent.width
          height: Math.max(80, implicitHeight)
          errorHighlight: text.length > 140
          placeholderText: "What did you think?"
          label: 140 - text.length
        }
      }

      VerticalScrollDecorator {}
  }
}
