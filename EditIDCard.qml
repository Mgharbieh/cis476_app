import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string nameText: ""
    property string birthdayText: ""
    property string genderText: ""
    property string heightText: ""
    property string addressText: ""

    property int currentItem: -1
    property bool editable: false

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
                right: parent.right

                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "John Doe"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: holderNameInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", holderNameInput.text)
                holderNameInputRect.border.color = "#969696"
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
                id: birthdayTextID
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
                right: parent.right

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
            enabled: editable

            placeholderText: "mm/dd/yyyy"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: birthdayInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
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
                birthdayInputRect.border.color = "#969696"
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
                id: genderTextID
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
                right: parent.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "M/F"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: genderInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", genderInput.text)
                genderInputRect.border.color = "#969696"
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
                id: heightTextID
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
                right: parent.right

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
            enabled: editable

            placeholderText: "6'0"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: heightInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
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
                heightInputRect.border.color = "#969696"
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
                id: addressTextID
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
                right: parent.right

                topMargin: 20
                rightMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "1234 Example Road, Dearborn MI, 48123"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: addressInputRect

                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", genderInput.text)
            }
        }

        Rectangle {
            id: missingFieldRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                top: addressInput.bottom
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

                text: editable === true ? "Update" : "Edit"
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
                    if(birthdayInput.text == "")
                    {
                        birthdayInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(genderInput.text == "")
                    {
                        genderInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(heightInput.text == "")
                    {
                        heightInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(addressInput.text == "")
                    {
                        addressInputRect.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false)
                    {
                        if(editable === false) {
                            holderNameInputRect.border.color = "#969696"
                            birthdayInputRect.border.color = "#969696"
                            genderInputRect.border.color = "#969696"
                            heightInputRect.border.color = "#969696"
                            addressInputRect.border.color = "#969696"
                            editable = true
                        }
                        else if(editable === true) {
                            var changed = false
                            if(holderNameInput.text !== nameText) {
                                DATABASE.updateField(currentItem, "ID card", nameText, "name", holderNameInput.text)
                                changed = true
                            }
                            if(birthdayInput.text !== birthdayText) {
                                DATABASE.updateField(currentItem, "ID card", nameText, "birthday", birthdayInput.text)
                                changed = true
                            }
                            if(genderInput.text !== genderText) {
                                DATABASE.updateField(currentItem, "ID card", nameText, "gender", genderInput.text)
                                changed = true
                            }
                            if(heightInput.text !== heightText) {
                                DATABASE.updateField(currentItem, "ID card", nameText, "height", heightInput.text)
                                changed = true
                            }
                            if(addressInput.text !== addressText) {
                                DATABASE.updateField(currentItem, "ID card", nameText, "address", addressInput.text)
                                changed = true
                            }
                            if(changed === true) {
                                DATABASE.updateCC(currentItem, holderNameInput.text, ccNumInput.text, cvvInput.text, expiryDateInput.text, zipCodeInput.text)
                            }

                            idCard.parent.visible = false
                            focusBackground.visible = false
                            rootWindow.isFocused = true
                            missingFieldRect.visible = false

                            holderNameInputRect.border.color = "transparent"
                            birthdayInputRect.border.color = "transparent"
                            genderInputRect.border.color = "transparent"
                            heightInputRect.border.color = "transparent"
                            addressInputRect.border.color = "transparent"
                            editable = false

                            //weakPasswordWarning.visible = false
                        }
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
            color: accent1color

            anchors {
                right: saveButtonRect.left
                bottom: idCardFrame.bottom

                rightMargin: parent.width * 0.02
                bottomMargin: parent.height * 0.02
            }

            Button {
                id: cancelCard
                anchors.fill: parent
                //enabled: isFocused

                text: "Close"
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
                    idCard.parent.visible = false;
                    rootWindow.backgroundRect.visible = false;
                    rootWindow.isFocused = true;
                    missingFieldRect.visible = false

                    holderNameInputRect.border.color = "transparent"
                    birthdayInputRect.border.color = "transparent"
                    genderInputRect.border.color = "transparent"
                    heightInputRect.border.color = "transparent"
                    addressInputRect.border.color = "transparent"

                    holderNameInput.text = ""
                    birthdayInput.text = ""
                    genderInput.text = ""
                    heightInput.text = ""
                    addressInput.text = ""
                    editable = false
                }
            }
        }
    }

    Rectangle {
        id: deleteButtonRect

        height: parent.height * .15
        width: parent.width * .2
        radius: 10
        color: "#FF0000"

        anchors {
            left: parent.left
            bottom: idCardFrame.bottom

            leftMargin: parent.width * 0.02
            bottomMargin: parent.height * 0.02
        }

        Button {
            id: deleteID
            anchors.fill: parent
            //enabled: isFocused

            text: "Delete"
            font.pixelSize: 25
            font.bold: true
            flat: true

            contentItem: Text {
                anchors.centerIn: parent
                text: deleteID.text
                font: deleteID.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#FFFFFF"
            }

            HoverHandler { cursorShape: Qt.PointingHandCursor }

            onClicked: { inactiveTimer.restart()
                holderNameInputRect.border.color = "transparent"
                birthdayInputRect.border.color = "transparent"
                genderInputRect.border.color = "transparent"
                heightInputRect.border.color = "transparent"
                addressInputRect.border.color = "transparent"

                holderNameInput.text = ""
                birthdayInput.text = ""
                genderInput.text = ""
                heightInput.text = ""
                addressInput.text = ""

                idCard.parent.visible = false
                focusBackground.visible = false
                rootWindow.isFocused = true
                missingFieldRect.visible = false

                savedModel.clear()
                DATABASE.deleteItem(currentItem, "ID card", "name", nameText)

                missingFieldRect.visible = false
                editable = false
            }
        }
    }

    function populateUI(_idx, _name, _bday, _gender, _height, _address) {
        currentItem = _idx

        holderNameInput.text = _name
        birthdayInput.text = _bday
        genderInput.text = _gender
        heightInput.text = _height
        addressInput.text = _address

        nameText = _name
        birthdayText = _bday
        genderText = _gender
        heightText = _height
        addressText = _address
    }
}
