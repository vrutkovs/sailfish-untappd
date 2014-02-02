import QtQuick 2.0
import Sailfish.Silica 1.0
import "UntappdApp.js" as App

Page {
  id: page

  onStatusChanged: {
    if (status != PageStatus.Active) return;
    if (App.isLoggedIn()) {
      pageStack.push(Qt.resolvedUrl("PersonalFeedPage.qml", {}, PageStackAction.Animated))
    } else {
      pageStack.push(Qt.resolvedUrl("LoginPage.qml"), {}, PageStackAction.Animated);
    }
  }

  BusyIndicator {
    running: true
    size: BusyIndicatorSize.Large
    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
  }

}
