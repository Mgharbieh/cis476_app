import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string ccNum: ""
    property string expiryDate: ""
    property string ccHolderName: ""
    property string cvv: ""
    property string zipCode: ""

    property string copyToClipboard: "📋"
    property int currentItem: -1
    property bool editable: false

    id: creditCard

    anchors.fill: parent

    Timer {
        id: copyNotifTimer
        interval: 1250
        onTriggered: {
            copyToClipboardRect.visible = false
        }
    }


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

        //height: 500
        //width: 300

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
                right: showHideNum.left

                topMargin: 5
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
             }
        }

        Rectangle {
            id: copyNameRect

            anchors {
                top: parent.top
                left: showHideNum.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyNameButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(holderNameInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyNameText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                ToolTip.text: "Copy to clipboard"
                ToolTip.visible: hovered

                HoverHandler { cursorShape: Qt.PointingHandCursor }
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

            echoMode: "Password"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "xxxx-xxxx-xxxx-xxxx"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: ccNumInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
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
            id: showNumButton

            anchors {
                top: holderNameRect.bottom
                right: copyNumRect.left

                topMargin: 20
                leftMargin: 10
                rightMargin: 10
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

                text: "show"
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
            id: copyNumRect

            anchors {
                top: ccNumInput.top
                left: showHideNum.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyNumButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(ccNumInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyNumText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                ToolTip.text: "Copy to clipboard"
                ToolTip.visible: hovered

                HoverHandler { cursorShape: Qt.PointingHandCursor }
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
            enabled: editable

            placeholderText: "mm/yy"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: expiryDateInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
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
            id: copyExpRect

            anchors {
                top: expiryDateInput.top
                left: showHideNum.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyExpButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(expiryDateInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyExpText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                ToolTip.text: "Copy to clipboard"
                ToolTip.visible: hovered

                HoverHandler { cursorShape: Qt.PointingHandCursor }
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

            echoMode: "Password"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "123"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: cvvInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", expiryDateInput.text)
            }
        }

        Rectangle {
            id: showCCVButton

            anchors {
                top: expiryDateInput.bottom
                right: copyCVVRect.left

                topMargin: 20
                leftMargin: 10
                rightMargin: 10
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

                text: "show"
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
            id: copyCVVRect

            anchors {
                top: cvvInput.top
                left: showHideNum.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyCCVButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(cvvInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyCCVText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                ToolTip.text: "Copy to clipboard"
                ToolTip.visible: hovered

                HoverHandler { cursorShape: Qt.PointingHandCursor }
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
            enabled: editable

            placeholderText: "12345"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: zipCodeInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", expiryDateInput.text)
            }
        }

        Rectangle {
            id: copyZipRect

            anchors {
                top: parent.top
                left: showHideNum.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyZipButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(zipCodeInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyZipText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                ToolTip.text: "Copy to clipboard"
                ToolTip.visible: hovered

                HoverHandler { cursorShape: Qt.PointingHandCursor }
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
            id: copyToClipboardRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                bottom: cancelButtonRect.top
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }

            border.width: 1
            border.color: "#00FF00"
            radius: 5
            color: "#3000FF00" // 80 is alpha value

            Text {
                color: "#00FF00"
                text: "Copied to clipboard!"
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
                    if(holderNameInput.text == "") {
                        holderNameInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(ccNumInput.text == "") {
                        ccNumInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(expiryDateInput.text == "") {
                        expiryDateInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(cvvInput.text == "") {
                        cvvInputRect.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(zipCodeInput.text == "") {
                        zipCodeInputRect.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false)
                    {
                        if(editable === false) {
                            holderNameInputRect.border.color = "#969696"
                            ccNumInputRect.border.color = "#969696"
                            expiryDateInputRect.border.color = "#969696"
                            cvvInputRect.border.color = "#969696"
                            zipCodeInputRect.border.color = "#969696"
                            editable = true
                        }
                        else if(editable === true) {
                            var changed = false
                            if(holderNameInput.text !== ccHolderName) {
                                DATABASE.updateField(currentItem, "credit card", ccNum, "name", holderNameInput.text)
                                changed = true
                            }
                            if(ccNumInput.text !== ccNum) {
                                DATABASE.updateField(currentItem, "credit card", ccNum, "credit_num", ccNumInput.text)
                                changed = true
                            }
                            if(expiryDateInput.text !== expiryDate) {
                                DATABASE.updateField(currentItem, "credit card", ccNum, "expiration", expiryDateInput.text)
                                changed = true
                            }
                            if(cvvInput.text !== cvv) {
                                DATABASE.updateField(currentItem, "credit card", ccNum, "credit_cvv", cvvInput.text)
                                changed = true
                            }
                            if(zipCodeInput.text !== zipCode) {
                                DATABASE.updateField(currentItem, "credit card", ccNum, "ziip_code", holderNameInput.text)
                                changed = true
                            }
                            if(changed === true) {
                                DATABASE.updateCC(currentItem, holderNameInput.text, ccNumInput.text, cvvInput.text, expiryDateInput.text, zipCodeInput.text)
                            }

                            creditCard.parent.visible = false
                            focusBackground.visible = false
                            rootWindow.isFocused = true
                            missingFieldRect.visible = false

                            holderNameInputRect.border.color = "transparent"
                            ccNumInputRect.border.color = "transparent"
                            expiryDateInputRect.border.color = "transparent"
                            cvvInputRect.border.color = "transparent"
                            zipCodeInputRect.border.color = "transparent"
                            editable = false
                            resetHidden()

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
                bottom: creditCardFrame.bottom

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

                    creditCard.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true
                    missingFieldRect.visible = false

                    holderNameInputRect.border.color = "transparent"
                    ccNumInputRect.border.color = "transparent"
                    expiryDateInputRect.border.color = "transparent"
                    cvvInputRect.border.color = "transparent"
                    zipCodeInputRect.border.color = "transparent"
                    resetHidden()
                    editable = false

                   //weakPasswordWarning.visible = false
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
            bottom: creditCardFrame.bottom

            leftMargin: parent.width * 0.02
            bottomMargin: parent.height * 0.02
        }

        Button {
            id: deleteWebsite
            anchors.fill: parent
            //enabled: isFocused

            text: "Delete"
            font.pixelSize: 25
            font.bold: true
            flat: true

            contentItem: Text {
                anchors.centerIn: parent
                text: deleteWebsite.text
                font: deleteWebsite.font
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#FFFFFF"
            }

            HoverHandler { cursorShape: Qt.PointingHandCursor }

            onClicked: { inactiveTimer.restart()
                holderNameInput.text = ""
                ccNumInput.text = ""
                expiryDateInput.text = ""
                cvvInput.text = ""
                zipCodeInput.text = ""

                holderNameInputRect.border.color = "transparent"
                ccNumInputRect.border.color = "transparent"
                expiryDateInputRect.border.color = "transparent"
                cvvInputRect.border.color = "transparent"
                zipCodeInputRect.border.color = "transparent"

                creditCard.parent.visible = false
                focusBackground.visible = false
                rootWindow.isFocused = true
                missingFieldRect.visible = false

                savedModel.clear()
                DATABASE.deleteItem(currentItem, "credit card", "credit_num", ccNum)

                missingFieldRect.visible = false
                resetHidden()
                editable = false
                //hidden = true
            }
        }
    }

    function populateUI(_idx, _name, _ccNum, _ccv, _exp, _zip) {
        currentItem = _idx

        holderNameInput.text = _name
        ccNumInput.text = _ccNum
        expiryDateInput.text = _exp
        cvvInput.text = _ccv
        zipCodeInput.text = _zip

        ccHolderName = _name
        ccNum = _ccNum
        expiryDate = _exp
        cvv = _ccv
        zipCode = _zip
    }

    function resetHidden() {
        ccNumInput.echoMode = "Password"
        cvvInput.echoMode = "Password"
        showHideNum.text = "show"
        showHideCCV.text = "show"
    }
}
