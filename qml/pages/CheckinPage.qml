import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App

Page {
  id: searchPage
  property string searchString

  SilicaListView {
      anchors.fill: parent
      currentIndex: -1 // otherwise currentItem will steal focus
      header:  Column {
        id: headerContainer

        width: searchPage.width

        PageHeader {
          title: "Drink up!"
        }

        SearchField {
          id: searchField
          width: parent.width

          Binding {
            target: searchPage
            property: "searchString"
            value: searchField.text.toLowerCase().trim()
          }
        }
      }

      VerticalScrollDecorator {}
  }
}
