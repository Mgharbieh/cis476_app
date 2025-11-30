import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string websiteName: ""
    property string loginUserName: ""
    property string loginPassWord: ""
    property int currentItem: -1

    property string copyToClipboard: "📋"
    property bool editable: false
    property bool hidden: true

    id: website

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
            text: "Saved Website"

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

            width: 155
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
            id: editWebsiteInput
            anchors {
                top: parent.top
                left: websiteNameRect.right
                right: editWebsitePassInput.right
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "www.example.com"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: textInputBackground
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", editWebsiteInput.text)
                textInputBackground.border.color = "#969696"
             }
        }

        Rectangle {
            id: copyUrlRect

            anchors {
                top: parent.top
                left: showHide.right
                right: parent.right
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyUrlButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(editWebsiteInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyUrlText
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
            id: websiteUserRect
            color: "transparent"

            anchors {
                top: websiteNameRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 155
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
            id: editWebsiteUserInput
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
            enabled: editable

            placeholderText: "Enter your username"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: userInputBackground
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", editWebsiteUserInput.text)
                userInputBackground.border.color = "#969696"
            }
        }

        Rectangle {
            id: copyUserRect

            anchors {
                top: websiteNameRect.bottom
                left: showHide.right
                right: parent.right

                topMargin: 20
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyUserButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(editWebsiteUserInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyUserText
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
            id: websitePassRect
            color: "transparent"

            anchors {
                top: websiteUserRect.bottom
                left: parent.left

                topMargin: 20
            }

            width: 155
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
            id: editWebsitePassInput
            anchors {
                top: websiteUserRect.bottom
                left: websiteUserRect.right
                right: showPassButton.left

                topMargin: 20
                rightMargin: 20
            }

            echoMode: hidden === true ? "Password" : "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5
            enabled: editable

            placeholderText: "Enter password"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: passInputBackground
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                passInputBackground.border.color = "#969696"
            }
        }

        Rectangle {
            id: showPassButton

            anchors {
                top: websiteUserRect.bottom
                right: copyPassRect.left

                topMargin: 20
                leftMargin: 5
                rightMargin: 10
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

                text: hidden === true ? "show" : "hide"
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

                onClicked: { inactiveTimer.restart()
                   hidden = !hidden
                }
            }
        }

        Rectangle {
            id: copyPassRect

            anchors {
                top: websiteUserRect.bottom
                left: showHide.right
                right: parent.right

                topMargin: 20
            }

            width: 40
            height: 40
            color: "transparent"
            border.color: accent1color
            border.width: 1
            radius: 8

            Button {
                id: copyPassButton
                anchors.fill: parent
                anchors.margins: 1

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }

                onClicked: { inactiveTimer.restart()
                    CLIPBOARD.copyText(editWebsitePassInput.text)
                    copyToClipboardRect.visible = true
                    copyNotifTimer.start()
                    clearClipboardTimer.restart()
                }
            }

            Text {
                id: copyPassText
                anchors.centerIn: parent

                text: copyToClipboard
                color: accent1color
                font.pixelSize: 26

                HoverHandler { cursorShape: Qt.PointingHandCursor }
            }
        }

        Rectangle {
            id: missingFieldRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                top: showPassButton.bottom
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
                id: saveWebsite
                anchors.fill: parent
                //enabled: isFocused

                text: editable === true ? "Update" : "Edit"
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

                onClicked: { inactiveTimer.restart()
                    // ADD SAVE FUNCTIONALITY HERE ONCE DATABASE IS IMPLEMENTED //
                    var incomplete = false
                    if(editWebsiteInput.text === "")
                    {
                        textInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(editWebsiteUserInput.text === "")
                    {
                        userInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(editWebsitePassInput.text === "")
                    {
                        passInputBackground.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false)
                    {
                        if(editable == false) {
                            websiteName = editWebsiteInput.text
                            loginUserName = editWebsiteUserInput.text
                            loginPassWord = editWebsitePassInput.text

                            textInputBackground.border.color = "#969696"
                            userInputBackground.border.color = "#969696"
                            passInputBackground.border.color = "#969696"
                            editable = true
                        }
                        else if(editable == true)
                        {
                            var changed = false
                            if(websiteName !== editWebsiteInput.text) {
                                DATABASE.updateField(currentItem, "website", editWebsiteInput.text, "url", editWebsiteInput.text)
                                changed = true
                            }
                            if(loginUserName !== editWebsiteUserInput.text) {
                                DATABASE.updateField(currentItem, "website", editWebsiteInput.text, "username", editWebsiteUserInput.text)
                                changed = true
                            }
                            if(loginPassWord !== editWebsitePassInput.text) {
                                DATABASE.updateField(currentItem, "website", editWebsiteInput.text, "password", editWebsitePassInput.text)
                                changed = true
                            }
                            if(changed == true) {
                                DATABASE.updateWebsite(currentItem, editWebsiteInput.text, editWebsiteUserInput.text, editWebsitePassInput.text)
                            }

                            website.parent.visible = false
                            focusBackground.visible = false
                            rootWindow.isFocused = true
                            missingFieldRect.visible = false

                            textInputBackground.border.color = "transparent"
                            userInputBackground.border.color = "transparent"
                            passInputBackground.border.color = "transparent"

                            editable = false
                            hidden = true
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

                text: "Close"
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

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: { inactiveTimer.restart()
                    editWebsiteInput.text = ""
                    editWebsiteUserInput.text = ""
                    editWebsitePassInput.text = ""

                    textInputBackground.border.color = "transparent"
                    userInputBackground.border.color = "transparent"
                    passInputBackground.border.color = "transparent"

                    website.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true

                    missingFieldRect.visible = false
                    editable = false
                    hidden = true
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
                bottom: websiteFrame.bottom

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
                    editWebsiteInput.text = ""
                    editWebsiteUserInput.text = ""
                    editWebsitePassInput.text = ""

                    textInputBackground.border.color = "transparent"
                    userInputBackground.border.color = "transparent"
                    passInputBackground.border.color = "transparent"

                    website.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true

                    savedModel.clear()
                    DATABASE.deleteItem(currentItem, "website", "url", websiteName)

                    missingFieldRect.visible = false
                    editable = false
                    hidden = true
                }
            }
        }
    }

    function populateUI(_idx, _url, _user, _pass) {
        console.log("EditWebsiteInfo: websiteLoaded", _url, _user, _pass)
        currentItem = _idx

        // Fill the fields
        editable = true
        editWebsiteInput.text = _url
        editWebsiteUserInput.text = _user
        editWebsitePassInput.text = _pass
        editable = false

        // Remember the original values if needed later
        websiteName = _url
        loginUserName = _user
        loginPassWord = _pass
    }
}
