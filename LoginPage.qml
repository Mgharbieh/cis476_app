import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string userName: ""
    property string passWord: ""

    id: loginScreen
    visible: true
    anchors.fill: parent
    z: 100

    signal createAccountClicked()
    signal recoverAccountClicked()

    Connections {
        target: LOGIN

        function onLogoutSignal() { loginScreen.visible = true }
    }

    Rectangle {
        id: root
        anchors.fill: parent
        color: "#FFFFFF"

        Rectangle{
           id: logo

           width: 500
           height: 300

           anchors {
               top: parent.top
               topMargin: 40
               horizontalCenter: parent.horizontalCenter

               //left: (parent.width - 200) / 2
               //bottomMargin: 20
           }

            Text {
               id: logoText
               anchors.centerIn: parent
               text: "MyPass"
               font.pixelSize: 100
               font.bold: true
               font.italic: true
               color: "#144F85"
               visible: true
               verticalAlignment: Text.AlignVCenter
           }
       }

       Rectangle {
           id: username

           width: 500
           height: 50

           anchors {
               top: logo.bottom
               horizontalCenter: parent.horizontalCenter
           }

           color: "#FFFFFF"

           TextField {
               id: usernameInput
               anchors {
                   top: parent.top
                   left:parent.left
                   right: parent.right
                   bottom: parent.bottom

                   topMargin: 5
                   leftMargin: 0
                   rightMargin: 0
                   bottomMargin: 5
               }

               echoMode: "Normal"
               font.pixelSize: 18
               color: "#000000"
               verticalAlignment: "AlignVCenter"
               leftPadding: 5

               placeholderText: "Username"
               placeholderTextColor: "#B8B8B8"

               onTextChanged: {
                              if(usernameInput.text.length === 0){
                                         recoverText.color = "#444444"
                                         recoverButton.enabled = false
                              } else{
                                         recoverText.color = "#0081FF"
                                         recoverButton.enabled = true
                              }
               }

               onEditingFinished: {
                   //debugging
                   console.log("Input finished:", usernameInput.text)
                   userName = usernameInput.text
               }
           }
       }

       Rectangle {
           id: password
           width: 500
           height: 50
           anchors {
               top: username.bottom
               topMargin: 5
               horizontalCenter: parent.horizontalCenter
           }

           color: "#FFFFFF"

           TextField {
               id: passwordInput
               anchors {
                   top: parent.top
                   left:parent.left
                   right: parent.right
                   bottom: parent.bottom

                   topMargin: 5
                   leftMargin: 0
                   rightMargin: 0
                   bottomMargin: 5
               }

               echoMode: "Password"
               font.pixelSize: 18
               color: "#000000"
               verticalAlignment: "AlignVCenter"
               leftPadding: 5

               placeholderText: "Password"
               placeholderTextColor: "#B8B8B8"


               onEditingFinished: {
                   //debugging
                   console.log("Input finished:", passwordInput.text)
                   passWord = passwordInput.text
                }
           }
       }

       Rectangle {
           id: recoverAccRect
           width: 500
           height: 40
           anchors {
               top: password.bottom
               topMargin: 5
               horizontalCenter: parent.horizontalCenter
           }

           Text {
               id: recover
               height: 30
               anchors{
                   top: parent.top
                   left: parent.left
                   leftMargin: 20
               }

               text: "Recover Master Password? "
               font.pixelSize: 18
               color: "#B5B5B5"
               visible: true
               //topPadding: 5
           }

           Button {
               id: recoverButton
               width: 175
               height: 30
               enabled: false
               anchors{
                   top: parent.top
                   left: recover.right
               }

               font{
                   pixelSize: 18
                   underline: true
               }

               contentItem: Text {
                    id: recoverText
                    text: "Recover"
                    font: parent.font
                    color: "#444444"
                    anchors.centerIn: parent
               }

               background: Rectangle {
                   color: "transparent"
                   radius: 10
               }

               HoverHandler {
                    cursorShape: Qt.PointingHandCursor
               }

               onClicked: { 
                   if(LOGIN.accountExists(userName)){
                              loginScreen.recoverAccountClicked()
                              recover.text = "Recover Master Password?"
                   }
                   else{
                              recover.text = "account does not exist"
                              recover.color = "#FF5555"
                   }
               }
           }
       }

       Rectangle {
           id: loginButtonRect
           width: 500
           height: 80

           anchors {
               top: recoverAccRect.bottom
               topMargin: 5
               horizontalCenter: parent.horizontalCenter
           }

           color: "#144F85"
           radius: 10

           Button {
               id:loginButton
               width: 500
               height: 80
               anchors.centerIn: parent

               font{
                   pixelSize: 60
                   bold: true
                   //italic: true
               }

               contentItem: Text {
                    id: buttonText
                    text: "Login"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    bottomPadding: 8
                    font: parent.font
                    color: "#FFFFFF"
                    anchors.centerIn: parent
               }

               background: Rectangle {
                   color: "transparent"
                   radius: 10
                   border.color: "#144F85"
                   border.width: 2
               }

               HoverHandler {
                   cursorShape: Qt.PointingHandCursor
                   onHoveredChanged: {
                       if (hovered) {
                           loginButton.background.color = "#FFFFFF"
                           buttonText.color = "#144F85"
                       } else {
                           loginButton.background.color = "#144F85"
                           buttonText.color = "#FFFFFF"
                       }
                   }
               }

               onClicked: {
                   var success = LOGIN.tryLogin(userName, passWord)
                   console.log(success)
                   if(success == true) {
                       loginScreen.visible = false
                       usernameInput.text = ""
                       passwordInput.text = ""
                   }
               }
           }
       }

       Rectangle {
           id: registerAccRect
           width: 500
           height: 40
           anchors {
               top: loginButtonRect.bottom
               topMargin: 5
               horizontalCenter: parent.horizontalCenter
           }

           Text {
               id: register
               height: 30
               anchors{
                   top: parent.top
                   left: parent.left
                   leftMargin: 20
               }

               text: "Don't have an account? "
               font.pixelSize: 18
               color: "#B5B5B5"
               visible: true
               //topPadding: 5
           }

           Button {
               id: registerButton
               width: 175
               height: 30
               anchors{
                   top: parent.top
                   left: register.right
               }

               font{
                   pixelSize: 18
                   underline: true
               }

               contentItem: Text {
                    id: registerText
                    text: "Click here to register"
                    font: parent.font
                    color: "#0081FF"
                    anchors.centerIn: parent
               }

               background: Rectangle {
                   color: "transparent"
                   radius: 10
               }

               HoverHandler {
                    cursorShape: Qt.PointingHandCursor
               }

               onClicked: loginScreen.createAccountClicked()

           }
       }

       Rectangle {
           id: quickLoginRect
           width: 500
           height: 40

           anchors {
               top: loginButtonRect.bottom
               topMargin: 50
               horizontalCenter: parent.horizontalCenter
           }

           color: "transparent"

           Button {
               id: quickLoginButton
               width: 500
               height: 40
               anchors.centerIn: parent

               text: "Quick Dev Login"
               font.pixelSize: 22
               font.bold: true
               flat: true

               contentItem: Text {
                   text: quickLoginButton.text
                   font: quickLoginButton.font
                   anchors.centerIn: parent
                   color: "#000000" // bright red for "danger"
               }

               background: Rectangle {
                   color: "transparent"
                   radius: 6
                   border.color: "#000000"
                   border.width: 2
               }

               HoverHandler {
                   cursorShape: Qt.PointingHandCursor
               }

               onClicked: {
                   console.log("QUICK DEV LOGIN TRIGGERED")
                   loginScreen.visible = false
                   usernameInput.text = ""
                   passwordInput.text = ""
               }
           }
       }
    }
}
