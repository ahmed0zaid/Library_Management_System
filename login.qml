    import QtQuick 2.15
    import QtQuick.Controls 2.15
    import QtQuick.Layouts 1.15

    ApplicationWindow {
        visible: true
        width: 1366
        height: 768
        title: "Library log-in"

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"

            Popup {
                id: loginPopup
                width: 200
                height: 100
                modal: true
                focus: true
                anchors.centerIn: parent

                Rectangle {
                    anchors.fill: parent
                    color: "white"
                    radius: 8


                    Column {
                        spacing: 20
                        anchors.centerIn: parent

                        Text {
                            text: "Incorrect ID or password!"
                            font.pixelSize: 16
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            width: parent.width
                        }

                        Button {
                            text: "Close"
                            width: 80
                            height: 30
                            font.pixelSize: 16

                            background: Rectangle {
                                color: "red"
                                radius: 5
                                border.color: "black"
                            }

                            onClicked: loginPopup.close()
                        }
                    }
                }
            }

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
                        text: "Login"
                        height: 200
                        width: 150
                        font.pixelSize: 50
                        font.bold: true
                    }

                    TextField {
                        id: loginId
                        placeholderText: "Student ID"
                        width: 550
                        height: 60
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
                        id: loginPassword
                        placeholderText: "Password"
                        echoMode: TextInput.Password
                        width: 550
                        height: 60
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
                        text: "   ENTER   "
                        width: 400
                        height: 50
                        font.pixelSize: 20
                        background: Rectangle {
                            color: "black"
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
                            if (userManager.login(loginId.text, loginPassword.text))
                                {
                                    stackLoader.source = "homeROMANCE.qml"
                                } else {
                                    loginPopup.open()
                                }
                        }



                        Text {
                            id: errorText
                            color: "red"
                            font.pixelSize: 14
                        }

                    }

                    Button {
                        text: "New here? Sign-Up"
                        width: 400
                        background: Rectangle {
                            color: "#aaaaaa"
                            border.color: "black"
                            border.width: 1
                        }

                        onClicked: {
                            stackLoader.source = "signup.qml"
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






