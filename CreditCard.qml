import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property int ccNum
    property date expiryDate
    property string ccHolderName: ""
    property int cvv
    property int zipCode

    id: creditCard

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
            text: "Add Credit Card"

            font.pixelSize: 40
            font.bold: true
            color: rootWindow.textColor
        }
    }

    Rectangle {
        id: creditCardFrame
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
            id: ccNumRect
            color: "transparent"

            anchors {
                top: holderNameRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: ccNumText
                anchors.fill: parent

                text: "Credic Card Num:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: ccNumInput
            anchors {
                top: holderNameRect.bottom
                left: ccNumRect.right

                topMargin: 20
                rightMargin: 20
            }

            validator: RegularExpressionValidator {
                regularExpression: /^\d{4}-\d{4}-\d{4}-\d{4}$/
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "xxxx-xxxx-xxxx-xxxx"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            maximumLength: 19
            property int previousLength: 0
            onTextChanged: {

                if (text.length > previousLength && (text.length === 4 || text.length === 9 || text.length === 14) && text.length < maximumLength) {
                    text += "-";
                    cursorPosition = text.length; // keep cursor at the end
                }
                previousLength = text.length;
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", ccNumInput.text)
            }
        }



        Rectangle {
            id: expiryDateRect
            color: "transparent"

            anchors {
                top: ccNumRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: expirtyDateText
                anchors.fill: parent

                text: "Expiry Date:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: expiryDateInput

            validator: RegularExpressionValidator {
                regularExpression: /^(0[1-9]|1[0-2])\/[0-9]{2}/
            }


            anchors {
                top: ccNumRect.bottom
                left: expiryDateRect.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "mm/yy"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            property int previousLength: 0

            onTextChanged: {
                if(text.length > previousLength && text.length === 2 && !text.includes("/")){
                    text = text + "/";
                    cursorPosition = text.length;
                }

                previousLength = text.length;
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", expiryDateInput.text)
            }
        }



        Rectangle {
            id: cvvRect
            color: "transparent"

            anchors {
                top: expiryDateRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: cvvText
                anchors.fill: parent

                text: "cvv:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: cvvInput
            anchors {
                top: expiryDateRect.bottom
                left: cvvRect.right

                topMargin: 20
                rightMargin: 20
            }

            validator: RegularExpressionValidator {
            regularExpression: /\d{3}/
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "123"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", expiryDateInput.text)
            }
        }


        Rectangle {
            id: zipCodeRect
            color: "transparent"

            anchors {
                top: cvvRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 195
            height: 40

            Text {
                id: zipCodeText
                anchors.fill: parent

                text: "Zip Code:  "
                font.pixelSize: 25
                color: rootWindow.textColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }


        TextField {
            id: zipCodeInput

            validator: RegularExpressionValidator {
            regularExpression: /\d{5}/
            }

            anchors {
                top: cvvRect.bottom
                left: zipCodeRect.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "12345"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", expiryDateInput.text)
            }
        }

        Row {
            id: buttonRow

            anchors {
                top: zipCodeRect.bottom
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

                onClicked: {
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

                onClicked: {
                    rootWindow.creditCardWindow.visible = false;
                    rootWindow.backgroundRect.visible = false;
                    rootWindow.isFocused = true;
                }
            }
        }


    }


}
