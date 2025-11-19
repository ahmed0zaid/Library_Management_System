import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 1366
    height: 768
    title: "Library App"

    Loader {
        id: stackLoader
        anchors.fill: parent
        source: "login.qml"
    }
}
