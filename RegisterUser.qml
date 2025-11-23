import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    id: registerScreen
    anchors.fill: parent
    visible: false      // start hidden; show it from Main.qml
    z: 101              // above main UI

    // hook these up later to C++/DB
    signal backToLoginRequested()
    signal registerRequested()

    property string emailText: ""
    property string masterPasswordText: ""
    property string confirmPasswordText: ""
    property string q1Text: ""
    property string a1Text: ""
    property string q2Text: ""
    property string a2Text: ""
    property string q3Text: ""
    property string a3Text: ""

    Rectangle {
        id: panel
        width: 600
        height: 520
        radius: 10
        color: "#FFFFFF"
        border.color: "#144F85"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 14

            Text {
                text: "Create MyPass Account"
                font.pixelSize: 26
                font.bold: true
                color: "#144F85"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            // Email
            Column {
                spacing: 4
                Text { text: "Email"; color: "#000" }
                TextField {
                    id: emailField
                    text: registerScreen.emailText
                    onTextChanged: registerScreen.emailText = emailField.text
                    placeholderText: "you@example.com"
                }
            }

            // Master password + confirm
            Column {
                spacing: 4
                Text { text: "Master Password"; color: "#000" }
                TextField {
                    id: masterField
                    echoMode: TextInput.Password
                    placeholderText: "Enter master password"
                    text: registerScreen.masterPasswordText
                    onTextChanged: registerScreen.masterPasswordText = masterField.text
                }
            }

            Column {
                spacing: 4
                Text { text: "Confirm Master Password"; color: "#000" }
                TextField {
                    id: confirmField
                    echoMode: TextInput.Password
                    placeholderText: "Re-enter master password"
                    text: registerScreen.confirmPasswordText
                    onTextChanged: registerScreen.confirmPasswordText = confirmField.text
                }
            }

            // Security questions (simple text version for now)
            Row {
                spacing: 10
                Column {
                    spacing: 4
                    Text { text: "Question 1"; color: "#000" }
                    TextField {
                        id: q1Field
                        placeholderText: "Security question 1"
                        text: registerScreen.q1Text
                        onTextChanged: registerScreen.q1Text = q1Field.text
                    }
                }
                Column {
                    spacing: 4
                    Text { text: "Answer 1"; color: "#000" }
                    TextField {
                        id: a1Field
                        placeholderText: "Answer"
                        text: registerScreen.a1Text
                        onTextChanged: registerScreen.a1Text = a1Field.text
                    }
                }
            }

            Row {
                spacing: 10
                Column {
                    spacing: 4
                    Text { text: "Question 2"; color: "#000" }
                    TextField {
                        id: q2Field
                        placeholderText: "Security question 2"
                        text: registerScreen.q2Text
                        onTextChanged: registerScreen.q2Text = q2Field.text
                    }
                }
                Column {
                    spacing: 4
                    Text { text: "Answer 2"; color: "#000" }
                    TextField {
                        id: a2Field
                        placeholderText: "Answer"
                        text: registerScreen.a2Text
                        onTextChanged: registerScreen.a2Text = a2Field.text
                    }
                }
            }

            Row {
                spacing: 10
                Column {
                    spacing: 4
                    Text { text: "Question 3"; color: "#000" }
                    TextField {
                        id: q3Field
                        placeholderText: "Security question 3"
                        text: registerScreen.q3Text
                        onTextChanged: registerScreen.q3Text = q3Field.text
                    }
                }
                Column {
                    spacing: 4
                    Text { text: "Answer 3"; color: "#000" }
                    TextField {
                        id: a3Field
                        placeholderText: "Answer"
                        text: registerScreen.a3Text
                        onTextChanged: registerScreen.a3Text = a3Field.text
                    }
                }
            }

            // Buttons at the bottom
            Row {
                spacing: 16
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Back to Login"
                    onClicked: {
                        //tell Main.qml to swap screens
                        registerScreen.backToLoginRequested()
                    }
                }

                Button {
                    text: "Register"
                    onClicked: {
                        //add validation here.

                        if(masterPasswordText === confirmPasswordText) {
                            console.log("attempting to register account...")
                            DATABASE.registerAccount(emailText, masterPasswordText, q1Text, a1Text, q2Text, a2Text, q3Text, a3Text)
                            registerScreen.backToLoginRequested()
                        }
                        else {
                            console.log("Password does not match!")
                        }
                    }
                }
            }
        }
    }
}
