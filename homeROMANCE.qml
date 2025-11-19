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
                        color: modelData === "ROMANCE" ? "black"
                             : "#aaaaaa"
                        border.color: "black"
                    }

                    contentItem: Text {
                                    text: modelData
                                    color: modelData === "ROMANCE" ? "#aaaaaa"
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
                    ListElement { title: "Love Bond"; author: "B. Hale"; idcode: "ROM-009"; image: "qrc:/images/images/R LOVE BOND.png"; more: "A tender tale of soul-deep connection and a bond that survives distance, silence, and time." }
                    ListElement { title: "Endless Love"; author: "N. Sparks"; idcode: "ROM-002"; image: "qrc:/images/images/R ENDLESS LOVE.png"; more: "A heartwarming story of enduring love and how true emotions can stand the test of fate." }
                    ListElement { title: "Broken Vow"; author: "P. Young"; idcode: "ROM-014"; image: "qrc:/images/images/R BROKEN VOW.png"; more: "An emotional journey through betrayal, healing, and rediscovering love when trust is shattered." }
                    ListElement { title: "True Heart"; author: "J. Austen"; idcode: "ROM-004"; image: "qrc:/images/images/R TRUE HEART.png"; more: "A classic-style romance filled with dignity, sincerity, and the irresistible pull of a loyal heart." }
                    ListElement { title: "Love Again"; author: "S. Thorne"; idcode: "ROM-005"; image: "qrc:/images/images/R LOVE AGAIN.png"; more: "A story of second chances, where past wounds slowly bloom into renewed love and hope." }
                    ListElement { title: "Forever Us"; author: "M. Scott"; idcode: "ROM-006"; image: "qrc:/images/images/R FOR EVER US.png"; more: "Two hearts. One promise. A romantic tale about lasting devotion and the fight to keep love alive." }
                    ListElement { title: "Crimson Heart"; author: "T. Bailey"; idcode: "ROM-007"; image: "qrc:/images/images/R CRIMSON HEART.png"; more: "A passionate and thrilling love story filled with emotional intensity and fierce loyalty." }
                    ListElement { title: "Sweet Lies"; author: "K. Ryan"; idcode: "ROM-008"; image: "qrc:/images/images/R SWEET LIES.png"; more: "A romantic suspense where love and secrets collide, testing the power of truth and forgiveness." }
                    ListElement { title: "Soulmate"; author: "E. Hart"; idcode: "ROM-001"; image: "qrc:/images/images/R SOUL MATE.png"; more: "A moving story about destiny and the rare, electric connection that defines a soulmate." }
                    ListElement { title: "Silent Passion"; author: "L. Lane"; idcode: "ROM-010"; image: "qrc:/images/images/R SILENT.png"; more: "A soft-spoken romance where emotions speak louder than words, and love runs deep beneath the surface." }
                    ListElement { title: "Moonlight"; author: "V. Grant"; idcode: "ROM-011"; image: "qrc:/images/images/R MOONLIGHT.png"; more: "A poetic and dreamy love story unfolding under the stars, where every kiss feels timeless." }
                    ListElement { title: "Last Embrace"; author: "R. Hunter"; idcode: "ROM-012"; image: "qrc:/images/images/R LAST EMBRACE.png"; more: "A bittersweet romance about letting go, moving on, and cherishing one final embrace." }
                    ListElement { title: "Pure Desire"; author: "D. James"; idcode: "ROM-013"; image: "qrc:/images/images/R PURE DESIRE.png"; more: "A sensual and emotional tale of love driven by chemistry, longing, and untamed hearts." }
                    ListElement { title: "First Kiss"; author: "C. Hoover"; idcode: "ROM-003"; image: "qrc:/images/images/R FIRST KISS.png"; more: "Relive the magic of first love and the unforgettable spark of that very first kiss." }
                    ListElement { title: "Secret Touch"; author: "K. Keene"; idcode: "ROM-015"; image: "qrc:/images/images/R SECRET TOUCH.png"; more: "A forbidden romance wrapped in mystery, where every touch hides a deeper secret." }
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
