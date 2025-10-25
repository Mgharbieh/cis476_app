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
            text: "Add Webiste"

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
            topMargin: 20
            leftMargin: 30
            rightMargin: 30
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
            id: webisteInput
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
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", websiteInput.text)
             }
        }

        Rectangle {
            id: websitePassRect
            color: "transparent"

            anchors {
                top: websiteNameRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: websitePassText
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
                top: websiteNameRect.bottom
                left: websitePassRect.right
                right: showPassButton.left

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Password"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "[Put auto-generated password here]"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", websitePassInput.text)
            }
        }

        Rectangle {
            id: showPassButton

            anchors {
                top: websiteNameRect.bottom
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
    }
}
