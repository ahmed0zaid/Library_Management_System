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
                        color: modelData === "FINANCE" ? "black"
                             : "#aaaaaa"
                        border.color: "black"
                    }

                    contentItem: Text {
                                    text: modelData
                                    color: modelData === "FINANCE" ? "#aaaaaa"
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
                    ListElement { title: "The Ledger"; author: "A. Todd"; idcode: "FIN-022"; image: "qrc:/images/images/THE LEADGER.png"; more: "A foundational book on financial record-keeping, helping readers track their assets and liabilities clearly." }
                    ListElement { title: "Net Worth"; author: "R. Sethi"; idcode: "FIN-007"; image: "qrc:/images/images/NETWRTH.png"; more: "Understand how to calculate, grow, and protect your net worth with strategic financial planning." }
                    ListElement { title: "Wealth Map"; author: "G. Clason"; idcode: "FIN-008"; image: "qrc:/images/images/Design sans titre (2) copy 2.png"; more: "A timeless roadmap to wealth based on classic principles of saving, investing, and discipline." }
                    ListElement { title: "Smart Equity"; author: "J. Stanley"; idcode: "FIN-030"; image: "qrc:/images/images/SMART EQUITY.png"; more: "Explores smart equity investments and how to build wealth through long-term stock strategies." }
                    ListElement { title: "Crypto Start"; author: "M. Green"; idcode: "FIN-023"; image: "qrc:/images/images/CRYPTO START.png"; more: "A beginner's guide to understanding cryptocurrency and starting your journey into digital finance." }
                    ListElement { title: "The Budget"; author: "P. Lynch"; idcode: "FIN-011"; image: "qrc:/images/images/Design sans titre (3).png"; more: "Master the art of budgeting with practical tools for managing daily expenses and saving effectively." }
                    ListElement { title: "Market Play"; author: "G. Soros"; idcode: "FIN-012"; image: "qrc:/images/images/Design sans titre (2) copy 5.png"; more: "Insights from a legendary investor on navigating the stock market with strategy and foresight." }
                    ListElement { title: "Finance Fix"; author: "J. Collins"; idcode: "FIN-013"; image: "qrc:/images/images/Design sans titre (3) copy.png"; more: "A financial repair kit for individuals looking to take back control of their money and eliminate debt." }
                    ListElement { title: "Safe Bet"; author: "E. Lowry"; idcode: "FIN-014"; image: "qrc:/images/images/Design sans titre (4).png"; more: "Conservative investment techniques for steady returns and financial peace of mind." }
                    ListElement { title: "Fast Assets"; author: "M. Lewis"; idcode: "FIN-015"; image: "qrc:/images/images/Design sans titre (5).png"; more: "A look at high-speed financial growth and the risks and rewards of rapid investments." }
                    ListElement { title: "Fund Rules"; author: "J. Siegel"; idcode: "FIN-016"; image: "qrc:/images/images/Design sans titre (6).png"; more: "Essential rules and principles for investing in mutual funds and retirement planning." }
                    ListElement { title: "Income Plan"; author: "K. Shen"; idcode: "FIN-017"; image: "qrc:/images/images/Design sans titre (2) copy 6.png"; more: "A step-by-step plan to create multiple streams of income for long-term financial independence." }
                    ListElement { title: "Stock Hack"; author: "D. Ramsey"; idcode: "FIN-018"; image: "qrc:/images/images/Design sans titre (3) copy 2.png"; more: "Simple stock market hacks to help beginners trade smarter and manage risks." }
                    ListElement { title: "Value Vault"; author: "R. Dalio"; idcode: "FIN-019"; image: "qrc:/images/images/Design sans titre (2) copy 7.png"; more: "Unlock long-term value investing techniques from one of the world’s top hedge fund managers." }
                    ListElement { title: "Wise Wallet"; author: "J. Bogle"; idcode: "FIN-006"; image: "qrc:/images/images/Design sans titre (2).png"; more: "Guidance from the founder of index investing on building a wise and resilient financial life." }
                    ListElement { title: "Trade Code"; author: "C. Mayer"; idcode: "FIN-021"; image: "qrc:/images/images/Design sans titre (2) copy 8.png"; more: "A powerful blueprint for decoding the market and creating consistent trading success." }
                    ListElement { title: "Money Seed"; author: "W. Buffett"; idcode: "FIN-020"; image: "qrc:/images/images/Design sans titre (3) copy 3.png"; more: "Warren Buffett’s philosophy of planting financial seeds today to grow wealth tomorrow." }
                    ListElement { title: "Cash Flow"; author: "S. Pape"; idcode: "FIN-010"; image: "qrc:/images/images/Design sans titre (2) copy 4.png"; more: "Learn to manage cash flow effectively for both business and personal finances." }
                    ListElement { title: "Rich Life"; author: "H. Marks"; idcode: "FIN-024"; image: "qrc:/images/images/RICH LIFE.png"; more: "A practical and philosophical guide to building a life of wealth, purpose, and happiness." }
                    ListElement { title: "Coin Logic"; author: "V. Robin"; idcode: "FIN-025"; image: "qrc:/images/images/COM LOGIC.png"; more: "The logical foundations of cryptocurrency and how it’s reshaping modern finance." }
                    ListElement { title: "Saving Way"; author: "B. Tversky"; idcode: "FIN-026"; image: "qrc:/images/images/SAVING WAY.png"; more: "Practical saving strategies grounded in behavioral economics and daily discipline." }
                    ListElement { title: "Quick Gains"; author: "M. Kahneman"; idcode: "FIN-027"; image: "qrc:/images/images/QUICK GAINS.png"; more: "Explore how decision-making affects short-term profits and rapid investment gains." }
                    ListElement { title: "Tax Tricks"; author: "D. Dorsey"; idcode: "FIN-028"; image: "qrc:/images/images/TAX TRICKS.png"; more: "Smart tax-saving techniques and loopholes every taxpayer should know." }
                    ListElement { title: "Penny Plan"; author: "S. Johnson"; idcode: "FIN-029"; image: "qrc:/images/images/PEANY PLAN.png"; more: "Master frugal budgeting and penny-wise financial habits to reach your savings goals." }
                    ListElement { title: "Profit Path"; author: "D. Bach"; idcode: "FIN-009"; image: "qrc:/images/images/Design sans titre (2) copy 3.png"; more: "Follow a clear, proven path to grow your income and increase profit steadily over time." }
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







