# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = Untappd

CONFIG += sailfishapp

SOURCES += src/Untappd.cpp

OTHER_FILES += qml/Untappd.qml \
    qml/cover/CoverPage.qml \
    rpm/Untappd.spec \
    rpm/Untappd.yaml \
    Untappd.desktop \
    qml/UntappdListModel.qml \
    images/untappd-575x240.jpg \
    qml/pages/UntappdApp.js \
    qml/pages/settings.js \
    qml/pages/PersonalFeedPage.qml \
    qml/pages/LoadingPage.qml \
    qml/pages/LoginPage.qml \
    qml/pages/req.js \
    qml/pages/keys.js \
    qml/pages/CheckinPage.qml \
    qml/pages/SearchPage.qml \
    lib/underscore.js \
    qml/pages/BeerPage.qml \
    qml/pages/keys.js

RESOURCES += \
    resources.qrc

