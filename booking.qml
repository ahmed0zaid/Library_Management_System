import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: bookingPopup
    width: 200
    height: 130
    modal: true
    focus: true
    background: Rectangle {
        color: "white"
        radius: 10
        border.color: "black"
    }

    anchors.centerIn: Overlay.overlay

    property string bookId: ""

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Image {
            id: name
            source: "qrc:/images/images/atttt.png"
        }
        Text {
            id: confirm
            text: qsTr("THE BOOK OF ID:" + bookingPopup.bookId) + "\n" + "IS BOOKED SUCCEFULLY !"
        }

        Button {
            text: "               OK               "
            background: Rectangle {
            color: "#f7cb3b"
                    radius: 6
                    border.color: "black"
             }
            onClicked: {
                bookingManager.storeBooking(userManager.getStudentId(), bookingPopup.bookId)
                bookingPopup.close()
            }
        }
    }
}
