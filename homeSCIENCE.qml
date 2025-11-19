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
                        color: modelData === "SCIENCE & TECH" ? "black"
                             : "#aaaaaa"
                        border.color: "black"
                    }

                    contentItem: Text {
                                    text: modelData
                                    color: modelData === "SCIENCE & TECH" ? "#aaaaaa"
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
                    ListElement { title: "Dark Matter"; author: "M. Gates"; idcode: "SCI-013"; image: "qrc:/images/images/SDARK MATTER.png"; more: "Explore the mysterious, unseen side of the universe and the science behind dark energy and matter." }
                    ListElement { title: "Quantum Bit"; author: "R. Dawkins"; idcode: "SCI-002"; image: "qrc:/images/images/SQUATUM BIT.png"; more: "A beginner-friendly dive into quantum computing and how bits evolve into qubits." }
                    ListElement { title: "Data Core"; author: "N. deGrasse Tyson"; idcode: "SCI-003"; image: "qrc:/images/images/SDATA CORE.png"; more: "Understand the digital heartbeat of modern systems: where data lives, moves, and drives decisions." }
                    ListElement { title: "Smart Tech"; author: "B. Greene"; idcode: "SCI-004"; image: "qrc:/images/images/SSMART TECH.png"; more: "An overview of emerging smart technologies transforming our daily lives and industries." }
                    ListElement { title: "Deep Code"; author: "M. Kaku"; idcode: "SCI-005"; image: "qrc:/images/images/SDEEP CODE.png"; more: "A visionary look at how deep learning and algorithms shape the future of human-computer interaction." }
                    ListElement { title: "Nano Bots"; author: "C. Sagan"; idcode: "SCI-006"; image: "qrc:/images/images/SNANO BOTS.png"; more: "A fascinating journey into the tiny world of nanotechnology and its life-saving applications." }
                    ListElement { title: "Bio Hack"; author: "J. Gleick"; idcode: "SCI-007"; image: "qrc:/images/images/SBIO HACK.png"; more: "Explore how biology meets engineering in the rising world of biohacking and synthetic design." }
                    ListElement { title: "Next Gen"; author: "S. Mukherjee"; idcode: "SCI-008"; image: "qrc:/images/images/SNEXT GEN.png"; more: "A look into future generations of technology and what breakthroughs are just over the horizon." }
                    ListElement { title: "Brain Net"; author: "W. Isaacson"; idcode: "SCI-009"; image: "qrc:/images/images/SBRAIN NET.png"; more: "Dive into the evolving link between neuroscience and networks that might soon connect minds." }
                    ListElement { title: "Core Logic"; author: "B. Bryson"; idcode: "SCI-010"; image: "qrc:/images/images/SCORE LOGIC.png"; more: "Demystify the core principles of logic that drive computation, code, and critical thinking." }
                    ListElement { title: "Fast Chip"; author: "M. Kolbert"; idcode: "SCI-011"; image: "qrc:/images/images/SFAST SHIP.png"; more: "Discover the story of microchips—from silicon to speed—and how they revolutionized modern devices." }
                    ListElement { title: "Light Speed"; author: "E. Snowden"; idcode: "SCI-012"; image: "qrc:/images/images/SLIGHT SPEED.png"; more: "Examine the physics, theories, and breakthroughs racing toward faster-than-light communication." }
                    ListElement { title: "Future AI"; author: "S. Hawking"; idcode: "SCI-001"; image: "qrc:/images/images/SFUTURE AI.png"; more: "A bold forecast on how artificial intelligence may shape, serve, or surpass humanity." }
                    ListElement { title: "Sky Lab"; author: "R. Kanigel"; idcode: "SCI-014"; image: "qrc:/images/images/SSKY LAB.png"; more: "Follow the history and promise of space labs orbiting the Earth and studying the cosmos." }
                    ListElement { title: "Green Fuel"; author: "J. Watson"; idcode: "SCI-015"; image: "qrc:/images/images/SGREEN FUEL.png"; more: "The science behind renewable energy solutions and how green fuels power a sustainable tomorrow." }
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
