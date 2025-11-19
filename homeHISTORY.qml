import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Rectangle {
    width: 1366
    height: 768
    color: "#dddddd"


    Image {
        source: "qrc:/images/images/eaglesssssss.png"
        width: 150
        height: 200
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 55
        fillMode: Image.PreserveAspectFit
    }




    Column {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 30

        Row {
            width: parent.width
            height: 100
            spacing: 20

            Image {
                source: "qrc:/images/images/logocpp.png"
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
            }

            Item { width: 20 }

            Text {
                text: "A World of Words, A Universe of Knowledge"
                font.pixelSize: 32
                font.italic: true
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20


            Repeater {
                model: ["ROMANCE", "FINANCE", "SELF-HELP", "SCIENCE & TECH", "HISTORY"]
                delegate: Button {
                    text: modelData
                    font.pixelSize: 16
                    width: 150
                    height: 40

                    background: Rectangle {
                        radius: 6
                        color: modelData === "HISTORY" ? "black"
                             : "#aaaaaa"
                        border.color: "black"
                    }

                    contentItem: Text {
                                    text: modelData
                                    color: modelData === "HISTORY" ? "#aaaaaa"
                                         : "black"
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.fill: parent
                                }

                    onClicked: {
                        var page = "";
                        switch (modelData) {
                            case "ROMANCE":
                                page = "homeROMANCE.qml"; break;
                            case "FINANCE":
                                page = "homeFINANCE.qml"; break;
                            case "SELF-HELP":
                                page = "homeSELF.qml"; break;
                            case "SCIENCE & TECH":
                                page = "homeSCIENCE.qml"; break;
                            case "HISTORY":
                                page = "homeHISTORY.qml"; break;
                            default:
                                page = "homeFINANCE.qml"; break;
                        }

                        Qt.callLater(() => {
                            stackLoader.source = page;
                        });
                    }
                }
            }
        }
    }

    Popup {
        id: aboutus
        width: 1366
        height: 200
        modal: true
        focus: true
        background: Rectangle {
            color: "#dddddd"
        }

        property string bookId: ""


        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10
        Row {
            spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
            Image {
                source: "qrc:/images/images/mylogo.png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: "             Hello! My name is Ahmed-Zaid Errafii, a second-semester Computer Science student.
        This Library Management System project is part of my Object-Oriented Programming (OOP) coursework.
        The aim of the project is to create a clean, intuitive, and fully functional digital library that allows
        students to sign up, log in, explore categorized books, and book them using a smart interface.
        The system remembers the user after login, tracks their reading history, and maintains a record of book availability.
        Designed with Qt/QML and C++, this project demonstrates real-world application of class design, file handling,
        dynamic UI updates, and user-centered development.

                        >>Note: 'KNOWLEGDE HAS NO PRICE' everyone deserves access to books and learning.
                                 That's why no fees are applied for booking any of the books in this library."
            }
        }
        }

    }

    Popup {
        id: bookingPopup
        width: 400
        height: 300
        modal: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property string historyText: ""

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Text {
                text: "Booking History"
                font.pixelSize: 20
                font.bold: true
            }

            ScrollView {
                width: parent.width
                height: 200
                TextArea {
                    readOnly: true
                    text: bookingPopup.historyText
                    wrapMode: Text.WordWrap
                }
            }

            Button {
                text: "Close"
                onClicked: bookingPopup.close()
            }
        }
    }


    Drawer {
        id: menubar
        width: 255
        height: parent.height
        edge: Qt.LeftEdge
        modal: true

        background: Rectangle {
            color: "#aaaaaa"
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

            Image {
                id: profile
                source: "qrc:/images/images/TYTYTYTY.png"
                anchors.top: parent.top
            }

            Text {
                text: "  ● First name: " + userManager.getFirstName() + "\n" + "  ● Last name: "+ userManager.getLastName() +
                      "\n  ● Student ID: " + userManager.getStudentId()
                font.pixelSize: 20
                color: "black"
                anchors.top: parent.top
                anchors.topMargin: 110
            }

            Button {
                text: "  My Booking History  "
                width: 50
                height: 50
                font.pixelSize: 20
                anchors.top: parent.top
                anchors.topMargin: 220
                anchors.margins: 20
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                    color: "#dddddd"
                    radius: 6
                    border.color: "black"
                }
                onClicked: {
                    var history = userManager.getBookingHistory()
                    if (history.length > 0) {
                        bookingPopup.historyText = history.join("\n")
                        bookingPopup.open()
                    } else {
                        bookingPopup.historyText = "No bookings yet."
                        bookingPopup.open()
                    }
                }
            }

            Text {
                text: " - TOTAL BOOKS NUMBER: 85"
                font.pixelSize: 17
                color: "black"
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Text {
                id: myBookingCountText
                text: " - TOTAL BOOKED BOOKS: " + userManager.bookingCount
                font.pixelSize: 17
                color: "black"
                anchors.top: parent.top
                anchors.topMargin: 320
            }

            Connections {
                target: userManager
                onBookingCountChanged: {
                    var updated = userManager.bookingCount;
                    myBookingCountText.text = " - TOTAL BOOKED BOOKS: " + updated;
                    console.log("- Booking count updated:", userManager.bookingCount);
                }
            }

            Button {
                id: more
                text: "     About Us     "
                width: 50
                height: 30
                font.pixelSize: 20
                anchors.top: parent.buttom
                anchors.margins: 20
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                    color: "#dddddd"
                    radius: 6
                    border.color: "black"
                }
                onClicked: aboutus.open()
            }

            Button {
                id: logout
                text: "    >> Logout      "
                width: 25
                height: 25
                font.italic: true
                font.pixelSize: 24
                anchors.margins: 20
                background: Rectangle {
                    color: "#aaaaaa"
                    radius: 6
                }
                onClicked: {
                    stackLoader.source = "login.qml"
                }
            }
        }
    }


    Button {
        id: menuButton
        text: "☰"
        width: 50
        height: 50
        font.pixelSize: 24
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 20
        onClicked: menubar.open()
    }

    Popup {
        id: morePopup
        width: 300
        height: 200
        modal: true
        focus: true
        x: 500
        y: 250
        background: Rectangle {
            color: "#dddddd"
            radius: 6
            border.color: "black"
        }

        property string currentDescription: ""

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Text {
                text: "DESCRIPTION"
                font.pixelSize: 20
                font.bold: true
            }

            Text {
                text: morePopup.currentDescription
                wrapMode: Text.WordWrap
                anchors.fill: parent
                anchors.topMargin: 30
            }
        }
    }

    ScrollView {
        anchors.top: parent.top
        anchors.topMargin: 240
        anchors.left: parent.left
        anchors.rightMargin: 20
        anchors.bottom: parent.bottom

    GridLayout {
            id: bookGrid
            anchors.centerIn: parent
            columns: 5
            rowSpacing: 5
            columnSpacing: 5

            Repeater {
                model: ListModel {
                    ListElement { title: "War Path"; author: "Y.N. Harari"; idcode: "HIS-001"; image: "qrc:/images/images/H WAR PATH.png"; more: "A powerful chronicle of humanity’s conflicts and the reasons behind our endless battles." }
                    ListElement { title: "Old Kings"; author: "H. Zinn"; idcode: "HIS-002"; image: "qrc:/images/images/H OLD KINGS.png"; more: "A critical reflection on monarchies and the influence of ruling dynasties on world history." }
                    ListElement { title: "Empire Rise"; author: "J. Diamond"; idcode: "HIS-003"; image: "qrc:/images/images/H EMOIRE RISE.png"; more: "How geography and innovation helped ancient empires rise and conquer." }
                    ListElement { title: "Past Echo"; author: "D. McCullough"; idcode: "HIS-004"; image: "qrc:/images/images/H PAST ECHO.png"; more: "Voices and lessons from the past that still echo through modern civilization." }
                    ListElement { title: "Dark Age"; author: "W.L. Shirer"; idcode: "HIS-005"; image: "qrc:/images/images/H DARK AGE.png"; more: "A deep dive into the forgotten centuries of decline, fear, and transition in Europe." }
                    ListElement { title: "The Crown"; author: "P. Frankopan"; idcode: "HIS-006"; image: "qrc:/images/images/H CROWN.png"; more: "An elegant look at the power and legacy of monarchs through history’s shifting tides." }
                    ListElement { title: "Battle Cry"; author: "B. Tuchman"; idcode: "HIS-007"; image: "qrc:/images/images/H BATTLE CRY.png"; more: "Gripping accounts of history's most decisive battles and the cries that changed nations." }
                    ListElement { title: "Ancient Wars"; author: "T. Judt"; idcode: "HIS-008"; image: "qrc:/images/images/H ANCIENT WAR.png"; more: "A detailed analysis of warfare from Mesopotamia to Rome—where it all began." }
                    ListElement { title: "Lost Land"; author: "S.W. Bauer"; idcode: "HIS-009"; image: "qrc:/images/images/H LAST LAND.png"; more: "Uncover the rise and fall of forgotten civilizations and the lands they vanished from." }
                    ListElement { title: "Gold Trail"; author: "A. Roberts"; idcode: "HIS-010"; image: "qrc:/images/images/H GOLD TRAIL.png"; more: "Follow the global impact of gold and how it shaped trade, war, and empire." }
                    ListElement { title: "Cold War"; author: "R. Chernow"; idcode: "HIS-011"; image: "qrc:/images/images/H COLD WAR.png"; more: "A compelling overview of post-WWII tensions and the ideological divide that shaped the 20th century." }
                    ListElement { title: "Kingdom Fall"; author: "J.L. Gaddis"; idcode: "HIS-012"; image: "qrc:/images/images/H KINGDOOM FALL.png"; more: "An in-depth look at how once-great kingdoms collapsed from within." }
                    ListElement { title: "Iron Age"; author: "I. Wilkerson"; idcode: "HIS-013"; image: "qrc:/images/images/H IRONAGE.png"; more: "From tools to conquest: how the Iron Age revolutionized civilizations." }
                    ListElement { title: "Glory Days"; author: "E. Kolbert"; idcode: "HIS-014"; image: "qrc:/images/images/H GLORY DAYS.png"; more: "Relive the golden eras of prosperity and innovation across different empires." }
                    ListElement { title: "Old Roots"; author: "A. Applebaum"; idcode: "HIS-015"; image: "qrc:/images/images/H OLD ROOTS.png"; more: "Explore the foundational cultures and values that shaped modern societies." }
                }

                delegate: Rectangle {
                    width: 250
                    height: 400
                    radius: 10
                    color: "white"
                    border.color: "#aaaaaa"
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Image {
                            source: image
                            width: 230
                            height: 240
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: "Title: " + title
                            font.pixelSize: 16
                            color: "#aaaaaa"
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            text: "Author: " + author
                            font.pixelSize: 14
                            color: "#333333"
                        }

                        Text {
                            text: "ID: " + idcode
                            font.pixelSize: 14
                            color: "#666666"
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 10

                            Button {
                                id: bookingc
                                width: 110
                                text: "      Booking      "
                                Layout.alignment: Qt.AlignHCenter

                                background: Rectangle {
                                    color: "#dddddd"
                                    radius: 6
                                }


                                Component.onCompleted: {
                                    if (bookingManager.isBookBooked(idcode)) {
                                        bookingc.text = "    Booked    "
                                        bookingc.enabled = false
                                    }
                                }

                                onClicked: {
                                    var component = Qt.createComponent("booking.qml");
                                    if (component.status === Component.Ready) {
                                        var popup = component.createObject(parent);
                                        popup.bookId = idcode;
                                        popup.open();
                                        bookingc.text = "    Booked    "
                                        bookingc.enabled = false;
                                    } else {
                                        console.log("Error booking popup:", component.errorString());
                                    }
                                }
                            }
                        Button {
                            text: "      More      "
                            width: 110
                            Layout.alignment: Qt.AlignHCenter
                            background: Rectangle {
                                color: "#dddddd"
                                radius: 6
                            }
                            onClicked: {
                                morePopup.currentDescription = more;
                                morePopup.open();
                            }
                        }
                        }
                        }
                    }

                }
            }
    }

}
