/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0

Dialog {
  id: page

  canAccept: usernameField.text.length > 0 && passwordField.text.length > 0
  backNavigation: false
  acceptDestination: untappdAuthDropin

  onAccepted: {
    untappdAuthDropin.oauthUrl = App.oauthLoginUrl;
  }

  SilicaFlickable {
    anchors.fill: parent
    contentHeight: page.height
    width: page.width
    height: page.height

    DialogHeader {
      id: header
      title: "Log in"
    }

    Image {
      id: untappdLogo
      source: "qrc:/res/untappd.jpg"
      anchors.horizontalCenter: parent.horizontalCenter
      width: page.width - 100
      anchors.top: header.bottom
    }

    TextField {
      id: usernameField
      width: parent.width - 100
      anchors.horizontalCenter: parent.horizontalCenter
      placeholderText: "Username"
      focus: true
      inputMethodHints: Qt.ImhNoPredictiveText
      horizontalAlignment: TextInput.AlignHCenter
      anchors.topMargin: 30
      anchors.top: untappdLogo.bottom
    }

    TextField {
      id: passwordField
      width: parent.width - 100
      anchors.horizontalCenter: parent.horizontalCenter
      inputMethodHints: Qt.ImhNoPredictiveText
      echoMode: TextInput.Password
      placeholderText: "Password"
      horizontalAlignment: TextInput.AlignHCenter
      anchors.top: usernameField.bottom
      anchors.topMargin: -40
    }

    Component {
      id: untappdAuthDropin
      Page {

        BusyIndicator {
          running: true
          size: BusyIndicatorSize.Large
          anchors.verticalCenter: parent.verticalCenter
          anchors.horizontalCenter: parent.horizontalCenter
        }

        SilicaWebView {
          id: loginWebView
          anchors {
              top: parent.top
              left: parent.left
              right: parent.right
              bottom: parent.bottom
          }

          url: untappdAuthDropin.url

          onLoadingChanged: {
              switch (loadRequest.status) {
              case WebView.LoadSucceededStatus:
                  console.log('got a url of', loginWebView.url)
                  opacity = 1
                  break
              }
          }
        }
      }
    }
  }


}


