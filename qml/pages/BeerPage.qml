import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
  id: page
  property var beer
  SilicaFlickable {
    anchors.fill: parent
    contentWidth: parent.width
    contentHeight: col.height

    VerticalScrollDecorator {}

    Column {
      id: col
      spacing: Theme.paddingLarge
      width: parent.width
      Label {
        text: beer.beer.beer_name
        font.pixelSize: Theme.fontSizeExtraLarge
      }
      Label {
        text: beer.beer.beer_style
        color: Theme.secondaryColor
      }
      Label {
        text: beer.brewery.brewery_name
      }
    }
  }
}
