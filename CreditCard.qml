import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string ccNum: ""
    property string expiryDate: ""
    property string ccHolderName: ""
    property string cvv: ""
    property string zipCode: ""

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
            bottom: parent.bottom
            topMargin: 20
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 30
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
                right: ccNumInput.right

                topMargin: 5
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "John Doe"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: holderNameInputRect
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: { inactiveTimer.restart()
                holderNameInputRect.border.color = "#969696"
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

                text: "Credit Card Num:  "
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
                right: showNumButton.left

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
                id: ccNumInputRect
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

            onEditingFinished: { inactiveTimer.restart()
                ccNumInputRect.border.color = "#969696"
                console.log("Input finished:", ccNumInput.text)
            }
        }

        Rectangle {
            id: showNumButton

            anchors {
                top: holderNameRect.bottom
                right: parent.right

                topMargin: 20
                leftMargin: 10
                rightMargin: 20
            }

            color: "transparent"
            border.color: rootWindow.accent1color
            border.width: 1

            width: 75
            height: 40
            radius: 15

            Button {
                id: showHideNum
                anchors.centerIn: parent
                anchors.fill: parent

                text: "hide"
                font.pixelSize: 25
                flat: true

                contentItem: Text {
                    text: showHideNum.text
                    font: showHideNum.font
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

                onClicked: { inactiveTimer.restart()
                   if(showHideNum.text === "show") {
                       showHideNum.text = "hide"
                       ccNumInput.echoMode = "Normal"
                   }
                   else {
                       showHideNum.text = "show"
                       ccNumInput.echoMode = "Password"
                   }
                }
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
                right: ccNumInput.right

                topMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "mm/yy"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: expiryDateInputRect
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
                if (text.length === 0) {
                    ccExpiryWarning.visible = false;
                }
                else {
                    ccExpiryWarning.visible = DATABASE.isExpired(text);
                }

            }

            onEditingFinished: { inactiveTimer.restart()
                expiryDateInputRect.border.color = "#969696"
                console.log("Input finished:", expiryDateInput.text)
            }

        }

        Rectangle {
            id: ccExpiryWarning
            anchors {
                left: expiryDateInput.right
                verticalCenter: expiryDateInput.verticalCenter

                topMargin: 8
            }

            width: 250
            height: 40
            radius: 4
            color: "#30FF0000"
            visible: false

            Text {
                anchors.fill: parent
                text: "This credit card appears to be expired or invalid (mm/yy)."
                color: "#FF0000"
                font.pixelSize: 14
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
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
                right: ccNumInput.right

                topMargin: 20
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
                id: cvvInputRect
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {inactiveTimer.restart()
                cvvInputRect.border.color = "#969696"
                console.log("Input finished:", expiryDateInput.text)
            }
        }

        Rectangle {
            id: showCCVButton

            anchors {
                top: expiryDateInput.bottom
                right: parent.right

                topMargin: 20
                leftMargin: 10
                rightMargin: 20
            }

            color: "transparent"
            border.color: rootWindow.accent1color
            border.width: 1

            width: 75
            height: 40
            radius: 15

            Button {
                id: showHideCCV
                anchors.centerIn: parent
                anchors.fill: parent

                text: "hide"
                font.pixelSize: 25
                flat: true

                contentItem: Text {
                    text: showHideCCV.text
                    font: showHideCCV.font
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

                onClicked: { inactiveTimer.restart()
                   if(showHideCCV.text === "show") {
                       showHideCCV.text = "hide"
                       cvvInput.echoMode = "Normal"
                   }
                   else {
                       showHideCCV.text = "show"
                       cvvInput.echoMode = "Password"
                   }
                }
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
                right: ccNumInput.right

                topMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "12345"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: zipCodeInputRect
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: { inactiveTimer.restart()
                zipCodeInputRect.border.color = "#969696"
                console.log("Input finished:", expiryDateInput.text)
            }
        }

        Rectangle {
            id: missingFieldRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                top: zipCodeRect.bottom
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
                id: saveCard
                anchors.fill: parent
                //enabled: isFocused

                text: "Save"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: saveCard.text
                    font: saveCard.font
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

                onClicked: { inactiveTimer.restart()
                    var incomplete = false
                    if(holderNameInput.text == "")
                    {
                        holderNameInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(ccNumInput.text == "")
                    {
                        ccNumInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(expiryDateInput.text == "")
                    {
                        expiryDateInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(cvvInput.text == "")
                    {
                        cvvInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(zipCodeInput.text == "")
                    {
                        zipCodeInputRect.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false)
                    {
                        DATABASE.saveCC(holderNameInput.text, ccNumInput.text, cvvInput.text, expiryDateInput.text, zipCodeInput.text)

                        creditCard.parent.visible = false
                        focusBackground.visible = false
                        rootWindow.isFocused = true
                        missingFieldRect.visible = false

                        holderNameInput.text = ""
                        ccNumInput.text = ""
                        expiryDateInput.text = ""
                        cvvInput.text = ""
                        zipCodeInput.text = ""
                    }
                    else
                    {
                        missingFieldRect.visible = true
                    }
                    ccExpiryWarning.visible = false;

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
                bottom: creditCardFrame.bottom

                rightMargin: parent.width * 0.02
                bottomMargin: parent.height * 0.02
            }

            Button {
                id: cancelCard
                anchors.fill: parent
                //enabled: isFocused

                text: "Cancel"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: cancelCard.text
                    font: cancelCard.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#FFFFFF"
                }

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: { inactiveTimer.restart()
                    rootWindow.creditCardWindow.visible = false;
                    rootWindow.backgroundRect.visible = false;
                    rootWindow.isFocused = true;
                    missingFieldRect.visible = false

                    holderNameInputRect.border.color = "#969696"
                    ccNumInputRect.border.color = "#969696"
                    expiryDateInputRect.border.color = "#969696"
                    cvvInputRect.border.color = "#969696"
                    zipCodeInputRect.border.color = "#969696"

                    holderNameInput.text = ""
                    ccNumInput.text = ""
                    expiryDateInput.text = ""
                    cvvInput.text = ""
                    zipCodeInput.text = ""
                }
            }
        }
    }
}
