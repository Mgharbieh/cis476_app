import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string nameText: ""
    property string birthdayText: ""
    property string genderText: ""
    property string heightText: ""
    property string addressText: ""

    id: idCard

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
            text: "Add ID Card"

            font.pixelSize: 40
            font.bold: true
            color: rootWindow.textColor
        }
    }

    Rectangle {
        id: idCardFrame
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
            id: holderNameRect
            color: "transparent"

            anchors {
                top: parent.top
                left:parent.left
            }

            width: 195
            height: 40
            //border.color: "black"

            Text {
                id: holderNameText
                anchors.fill: parent

                text: "Holder Name:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }

        TextField {
            id: holderNameInput
            anchors {
                top: parent.top
                left: holderNameRect.right
                right: holderNameInput.right
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "John Doe"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", holderNameInput.text)
             }
        }


        Rectangle {
            id: birthdayRect
            color: "transparent"

            anchors {
                top: holderNameRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: birthdayText
                anchors.fill: parent

                text: "Birthday:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: birthdayInput
            anchors {
                top: holderNameRect.bottom
                left: birthdayRect.right

                topMargin: 20
                rightMargin: 20
            }

            validator: RegularExpressionValidator {
                regularExpression: /^(0[1-9]|1[0-2])\/(0[1-9]|1[1-9]|2[1-9]|3[0-1])\/[1-2][0-9]{3}/
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "mm/dd/yyyy"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }


            property int previousLength: 0

            onTextChanged: {
                if(text.length > previousLength && (text.length === 2 || text.length === 5)){
                    text = text + "/";
                    cursorPosition = text.length;
                }

                previousLength = text.length;
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", birthdayInput.text)
            }
        }



        Rectangle {
            id: genderRect
            color: "transparent"

            anchors {
                top: birthdayRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: genderText
                anchors.fill: parent

                text: "Gender:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: genderInput

            validator: RegularExpressionValidator {
                regularExpression: /^(M|F)/
            }


            anchors {
                top: birthdayRect.bottom
                left: genderRect.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "M/F"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", genderInput.text)
            }
        }



        Rectangle {
            id: heightRect
            color: "transparent"

            anchors {
                top: genderRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: heightText
                anchors.fill: parent

                text: "Height:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: heightInput
            anchors {
                top: genderRect.bottom
                left: heightRect.right

                topMargin: 20
                rightMargin: 20
            }

            validator: RegularExpressionValidator {
            regularExpression: /\d\'(\d|\d{2})/
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "6'0"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }


            property int previousLength: 0
            onTextChanged: {
                if(text.length > previousLength && text.length === 1){
                    text = text + "'"
                    cursorPosition = text.length
                }

                previousLength = text.length
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", genderInput.text)
            }
        }

        Rectangle {
            id: addressRect
            color: "transparent"

            anchors {
                top: heightRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: addressText
                anchors.fill: parent

                text: "Address:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: addressInput

            anchors {
                top: heightRect.bottom
                left: addressRect.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "1234 Example Road, Dearborn MI, 48123"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", genderInput.text)
            }
        }

        Row {
            id: buttonRow

            anchors {
                top: addressRect.bottom
                left: parent.left
                topMargin: 20
                leftMargin: 10
            }

            spacing: 10

            Button {
                id: saveButton
                text: "Save"
                font.pixelSize: 25
                flat: true
                width: 75
                height: 40

                background: Rectangle {
                    radius: 15
                    border.color: rootWindow.accent1color
                    border.width: 1
                    color: "transparent"
                }

                contentItem: Text {
                    text: saveButton.text
                    font: saveButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: rootWindow.textColor
                    anchors.centerIn: parent
                }

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: { inactiveTimer.restart()
                    // validate inputs, then save
                }
            }

            Button {
                id: cancelButton
                text: "Cancel"
                font.pixelSize: 25
                flat: true
                width: 75
                height: 40

                background: Rectangle {
                    radius: 15
                    border.color: rootWindow.accent1color
                    border.width: 1
                    color: "transparent"
                }

                contentItem: Text {
                    text: cancelButton.text
                    font: cancelButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: rootWindow.textColor
                    anchors.centerIn: parent
                }

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: { inactiveTimer.restart()
                    rootWindow.idCardWindow.visible = false;
                    rootWindow.backgroundRect.visible = false;
                    rootWindow.isFocused = true;
                }
            }
        }


    }


}
