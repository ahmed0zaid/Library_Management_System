import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1366
    height: 768
    title: "Library Sign-Up"

    Rectangle {
        anchors.fill: parent
        color: "#aaaaaa"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 80
            spacing: 60


            ColumnLayout {
                spacing: 25
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 1000
                x: 20

                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -190

                RowLayout {
                spacing: 60


                ColumnLayout {
                spacing: 25
                Layout.preferredWidth: 500

                Text {
                    text: "Sign-up"
                    font.pixelSize: 50
                    font.bold: true
                    height: 200
                    width: 150
                }

                TextField {
                    id: firstNameField
                    placeholderText: "First name"
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                TextField {
                    id: lastNameField
                    placeholderText: "Last name"
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                TextField {
                    id: studentIdField
                    placeholderText: "Student ID"
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                TextField {
                    id: phoneField
                    placeholderText: "Phone number"
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                TextField {
                    id: emailField
                    placeholderText: "Email"
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                TextField {
                    id: passwordField
                    placeholderText: "Create your password"
                    echoMode: TextInput.Password
                    width: 500
                    height: 50
                    font.pixelSize: 22
                    padding: 10
                    background: Rectangle {
                        width: 350
                        height: 42
                        radius: 8
                        border.color: "black"
                        border.width: 2
                        color: "#aaaaaa"
                    }
                }

                Button {
                    text: "   SUBMIT   "
                    width: 400
                    height: 50
                    font.pixelSize: 20

                    background: Rectangle {
                        color: "black"
                        radius: 8
                        border.color: "black"
                        border.width: 1
                    }

                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 20
                        color: "#aaaaaa"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.centerIn: parent
                    }

                    onClicked: {
                        userManager.signUp(
                            firstNameField.text,
                            lastNameField.text,
                            studentIdField.text,
                            passwordField.text
                        )
                        stackLoader.source = "login.qml"
                    }
                }
                Button {
                    text: "Already have an account? Login"
                    width: 400

                    background: Rectangle {
                        color: "#aaaaaa"
                        border.color: "black"
                        border.width: 1
                    }

                    onClicked: {
                        stackLoader.source = "login.qml"
                    }
                }
            }
            }
            }



            Rectangle {
                width: 600
                height: 600

                color: "#aaaaaa"
                radius: 30
                Layout.alignment: Qt.AlignVCenter

                Image {
                    width: 400
                    height: 600
                    anchors.fill: parent
                    anchors.margins: 20
                    source: "qrc:/images/images/logocpp.png"
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

    }
}





