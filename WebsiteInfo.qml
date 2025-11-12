import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string websiteName: ""
    property string loginUserName: ""
    property string loginPassWord: ""

    id: website

    anchors.fill: parent

    Rectangle {
        id: titleText
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 30
            leftMargin: 30
        }

        width: parent.width - 20
        height: 45
        color: "transparent"

        Text {
            id: title
            text: "Add Website"

            font.pixelSize: 40
            font.bold: true
            color: rootWindow.textColor
        }
    }

    Rectangle {
        id: websiteFrame
        visible: true
        color: "transparent"

        anchors {
            top: titleText.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 20
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 30
        }

        Rectangle {
            id: websiteNameRect
            color: "transparent"

            anchors {
                top: parent.top
                left:parent.left
            }

            width: 195
            height: 40
            //border.color: "black"

            Text {
                id:websiteNameText
                anchors.fill: parent

                text: "Website:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: websiteInput
            anchors {
                top: parent.top
                left: websiteNameRect.right
                right: websitePassInput.right
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "www.example.com"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: textInputBackground
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", websiteInput.text)
                textInputBackground.border.color = "#969696"
             }
        }

        Rectangle {
            id: websiteUserRect
            color: "transparent"

            anchors {
                top: websiteNameRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: websiteUserText
                anchors.fill: parent

                text: "Username:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: websiteUserInput
            anchors {
                top: websiteNameRect.bottom
                left: websitePassRect.right
                right: showPassButton.left

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "Enter your username"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: userInputBackground
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", websiteUserInput.text)
                userInputBackground.border.color = "#969696"
            }
        }

        Rectangle {
            id: websitePassRect
            color: "transparent"

            anchors {
                top: websiteUserRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: websitepassText
                anchors.fill: parent

                text: "Password:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: websitePassInput
            anchors {
                top: websiteUserRect.bottom
                left: websiteUserRect.right
                right: showPassButton.left

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Password"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "Enter password"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: passInputBackground
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", websitePassInput.text)
                passInputBackground.border.color = "#969696"
            }
        }

        Rectangle {
            id: showPassButton

            anchors {
                top: websiteUserRect.bottom
                right: parent.right

                topMargin: 20
                leftMargin: 10
            }

            color: "transparent"
            border.color: rootWindow.accent1color
            border.width: 1

            width: 75
            height: 40
            radius: 15

            Button {
                id: showHide
                anchors.centerIn: parent
                anchors.fill: parent

                text: "show"
                font.pixelSize: 25
                flat: true

                contentItem: Text {
                    text: showHide.text
                    font: showHide.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: rootWindow.textColor
                }

                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: "transparent"
                }

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: {
                   if(showHide.text === "show") {
                       showHide.text = "hide"
                       websitePassInput.echoMode = "Normal"
                   }
                   else {
                       showHide.text = "show"
                       websitePassInput.echoMode = "Password"
                   }
                }
            }
        }

        Rectangle {
            id: pwdBuilderRect
            width: 280
            height: 40
            anchors {
                top: websitePassInput.bottom
                topMargin: 5
                left: websitePassInput.left
            }

            color: "transparent"

            Button {
                id: pwdBuilderButton
                width: 175
                height: 30
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                font{
                    pixelSize: 18
                    underline: true
                }

                contentItem: Text {
                     id: pwdBuilderText
                     text: "Use auto-generated password"
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

                onClicked: {
                    websitePassInput.text = PASSBUILDER.build(10) //10 chars long, can be changed
                    passInputBackground.border.color = "#969696"
                }
            }
        }

        Rectangle {
            id: missingFieldRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                top: pwdBuilderRect.bottom
                topMargin: 5
                horizontalCenter: parent.horizontalCenter
            }

            border.width: 1
            border.color: "#FF0000"
            radius: 5
            color: "#30FF0000" // 80 is alpha value

            Text {
                color: "#FF0000"
                text: "Please enter missing fields"
                anchors.fill: parent
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            visible: false
        }


        Rectangle {
            id: saveButtonRect

            height: parent.height * .15
            width: parent.width * .2
            radius: 10
            color: rootWindow.accent1color

            anchors {
                right: parent.right
                bottom: parent.bottom

                rightMargin: parent.width * 0.02
                bottomMargin: parent.height * 0.02
            }

            Button {
                id: saveWebsite
                anchors.fill: parent
                //enabled: isFocused

                text: "Save"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: saveWebsite.text
                    font: saveWebsite.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#FFFFFF"
                }

                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: "transparent"
                }


                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: {
                    // ADD SAVE FUNCTIONALITY HERE ONCE DATABASE IS IMPLEMENTED //
                    var incomplete = false
                    if(websiteInput.text == "")
                    {
                        textInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(websiteUserInput.text == "")
                    {
                        userInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(websitePassInput.text == "")
                    {
                        passInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false)
                    {
                        website.parent.visible = false
                        focusBackground.visible = false
                        rootWindow.isFocused = true
                        missingFieldRect.visible = false
                    }
                    else
                    {
                        missingFieldRect.visible = true
                    }
                }
            }
        }

        Rectangle {
            id: cancelButtonRect

            height: parent.height * .15
            width: parent.width * .2
            radius: 10
            color: "#FF0000"

            anchors {
                right: saveButtonRect.left
                bottom: websiteFrame.bottom

                rightMargin: parent.width * 0.02
                bottomMargin: parent.height * 0.02
            }

            Button {
                id: cancelWebsite
                anchors.fill: parent
                //enabled: isFocused

                text: "Cancel"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: cancelWebsite.text
                    font: cancelWebsite.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#FFFFFF"
                }

                /*
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: "transparent"
                }
                */

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: {
                    websiteInput.text = ""
                    websiteUserInput.text = ""
                    websitePassInput.text = ""
                    website.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true

                    textInputBackground.border.color = "#969696"
                    userInputBackground.border.color = "#969696"
                    passInputBackground.border.color = "#969696"
                    missingFieldRect.visible = false
                }
            }
        }
    }
}
