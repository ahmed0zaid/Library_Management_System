import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: aboutus
    width: 1000
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


        Text {
            text: "     Hello! My name is Ahmed-Zaid Errafii, a second-semester Computer Science student.
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
