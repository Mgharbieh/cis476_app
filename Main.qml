import cis476_app

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Window {

    property string accent1color: "#144F85"
    property string backgroundcolor: "#FFFFFF"
    property string backgroundcolor2: "#D0D0D0"
    property string textColor: "#000000"
    property alias creditCardWindow: creditCardGUIFrame
    property alias idCardWindow: idCardGUIFrame
    property alias backgroundRect: backgroundRect
    property bool isFocused: true

    id: rootWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("MyPass")

    color: backgroundcolor

    Timer {
        id: inactiveTimer
        interval: 120000
        onTriggered: {
            LOGIN.logout()
        }
    }

    Timer {
        id: clearClipboardTimer
        interval: 5000
        onTriggered: {
            CLIPBOARD.clearClipboard();
        }
    }

    Connections {
        target: DATABASE

        function onItemLoaded(type, title, idx) {
            var newElem = {
                "type": type,
                "title": title,
                "index": idx
            }
            savedModel.append(newElem)
        }

        function onLoadedWeb(idx, url, user, pass) {
            console.log("Signal received in Main.qml")
            console.log(url, user, pass)
            editWebsiteObj.populateUI(idx, url, user, pass)
        }

        function onLoadCCSignal(idx, name, ccNum, ccv, exp, zip) {
            editCCObj.populateUI(idx, name, ccNum, ccv, exp, zip)
        }

        function onLoadIDSignal(idx, name, bday, gender, height, address) {
            editIDObj.populateUI(idx, name, bday, gender, height, address)
        }

        function onLoadNoteSignal(idx, title, text) {
            editNoteObj.populateUI(idx, title, text)
        }
    }

    Connections {
        target: DATABASE

        function onWeakPasswordFlagged(idx) {
            console.log("QML: weakPasswordFlagged for index", idx)

            if (idx >= 0 && idx < savedModel.count) {
                var item = savedModel.get(idx)
                console.log("QML: weak password for item:",
                            item.title, "type:", item.type)
            }
        }
    }

    Connections {
        target: DATABASE

        function onExpiryIssueFlagged(idx) {
            console.log("QML: expiryIssueFlagged for index", idx)

            if (idx >= 0 && idx < savedModel.count) {
                var item = savedModel.get(idx)
                console.log("QML: expired card for item:",
                            item.title, "type:", item.type)
            }
        }
    }

    LoginPage{
        id: loginPage

        onCreateAccountClicked: {
            loginPage.visible = true
            registerPage.visible = true
        }

        onRecoverAccountClicked: {
            loginPage.visible = true
            loginPage.enabled = false
            recoverPassPage.visible = true
        }
    }

    RegisterUser{
        id: registerPage

        onBackToLoginRequested: {
            registerPage.visible = false
            loginPage.visible = true
        }

        onRegisterRequested:{
            registerPage.visible = false
            loginPage.visible = true
        }
    }


    RecoverPassPage{
        id: recoverPassPage

        onBackToLoginRequested: {
            recoverPassPage.visible = false
            loginPage.visible = true
            loginPage.enabled = true
        }
    }



    Rectangle {
        id: demoWarning

        width: parent.width
        height: 40
        z: 101

        color: "transparent"
        border.color: "#969696"

        Text {
            anchors.fill: parent

            text: "!! UNSERCURE DEMO - DO NOT ENTER SENSITIVE INFORMATION !!"
            color: "#FF0000"
            font.bold: true
            fontSizeMode: Text.Fit
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

        }
    }

    Rectangle {
        id: welcomeMsgRect

        anchors {
            top: demoWarning.bottom
            left: parent.left
            topMargin: 5
            bottomMargin: 10
            leftMargin: 30
        }

        width: 300
        height: parent.height * 0.139
        color: "transparent"
        //border.color: "#000000" // temporary, need to find bounding edges

        Text {
            anchors.fill: parent
            color: textColor
            fontSizeMode: Text.Fit
            font.bold: true
            font.pixelSize: 500
            text: "Welcome,\n" + loginPage.userName + "!"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter

        }
    }

    Rectangle {
        id: lineSpacer

        width:300
        height: 2
        radius: 2

        anchors {
            top: welcomeMsgRect.bottom
            left: parent.left
            topMargin: 5
            bottomMargin: 5
            leftMargin: 30
        }

        color: "#969696"
    }

    Rectangle {
        id: buttonMenu

        anchors {
            top: lineSpacer.bottom
            bottom: lightDarkMode.top
            left: parent.left
            right: filler.left
            topMargin: 10
            bottomMargin: 5
            leftMargin: 30
            rightMargin: 20
        }

        //border.color: "#000000"
        color: "transparent"

        Column {
            anchors.fill: parent
            spacing: parent.height * .05

            Rectangle {
                id: websiteButton

                height: parent.height * .15
                width: parent.width
                radius: 10
                color: accent1color


                Button {
                    id: addWebsite
                    anchors.centerIn: parent
                    anchors.fill: parent
                    enabled: isFocused

                    text: "Website Login"
                    font.pixelSize: 25
                    font.bold: true
                    flat: true

                    contentItem: Text {
                        text: addWebsite.text
                        font: addWebsite.font
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
                        isFocused = false
                        backgroundRect.visible = true
                        websiteGUIFrame.visible = true
                    }
                }
            }

            Rectangle {
                id: creditCardButton

                height: parent.height * .15
                width: parent.width
                radius: 10
                color: accent1color

                Button {
                    id: addCreditCard
                    anchors.fill: parent
                    enabled: isFocused

                    text: "Credit Card"
                    font.pixelSize: 25
                    font.bold: true
                    flat: true

                    contentItem: Text {
                        anchors.centerIn: parent
                        text: addCreditCard.text
                        font: addCreditCard.font
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
                        isFocused = false
                        backgroundRect.visible = true
                        creditCardGUIFrame.visible = true
                    }
                }
            }

            Rectangle {
                id: identityButton

                height: parent.height * .15
                width: parent.width
                radius: 10
                color: accent1color

                Button {
                    id: addIdentity
                    anchors.fill: parent
                    enabled: isFocused

                    text: "ID Card"
                    font.pixelSize: 25
                    font.bold: true
                    flat: true

                    contentItem: Text {
                        anchors.centerIn: parent
                        text: addIdentity.text
                        font: addIdentity.font
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
                        isFocused = false
                        backgroundRect.visible = true
                        idCardGUIFrame.visible = true
                    }
                }
            }

            Rectangle {
                id: secureNoteButton

                height: parent.height * .15
                width: parent.width
                radius: 10
                color: accent1color

                Button {
                    id: addNote
                    anchors.fill: parent
                    enabled: isFocused

                    text: "Secure Note"
                    font.pixelSize: 25
                    font.bold: true
                    flat: true

                    contentItem: Text {
                        anchors.centerIn: parent
                        text: addNote.text
                        font: addNote.font
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
                        isFocused = false
                        backgroundRect.visible = true
                        noteGUIFrame.visible = true
                    }
                }
            }

            Rectangle {
                id: logoutButton

                height: parent.height * .15
                width: parent.width
                radius: 10
                color: "#FF0000"

                Button {
                    id: logout
                    anchors.fill: parent
                    enabled: isFocused

                    text: "Logout"
                    font.pixelSize: 25
                    font.bold: true
                    flat: true

                    contentItem: Text {
                        anchors.centerIn: parent
                        text: logout.text
                        font: logout.font
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

                    onClicked: { inactiveTimer.restart();LOGIN.logout()}
                }
            }
        }
    }

    Rectangle {
        id: backgroundRect
        anchors.fill: parent

        z: 2
        color: (backgroundcolor == "#FFFFFF") ? "#000000" : "#FFFFFF"
        opacity: 0.5
        visible: false
    } property alias focusBackground: backgroundRect

    Rectangle {
        id: websiteGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        WebsiteInfo {
            id: websiteInputObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: creditCardGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        CreditCard {
            id: creditCardInputObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: idCardGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        IDCard {
            id: idCardInputObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: noteGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        SecureNoteInfo {
            id: noteInputObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: editWebsiteGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        EditWebsiteInfo {
            id: editWebsiteObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: editCCGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        EditCreditCard {
            id: editCCObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: editIDGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        EditIDCard {
            id: editIDObj
            anchors.fill: parent
        }
    }

    Rectangle {
        id: editNoteGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 4

        anchors {
            top: parent.top
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }

        EditSecureNoteInfo {
            id: editNoteObj
            anchors.fill: parent
        }
    }

    Switch {
        id: lightDarkMode
        onClicked: switchColorMode()

        //height: 20
        //width: 60

        indicator: Rectangle {
            implicitWidth: 48
            implicitHeight: 26
            x: lightDarkMode.leftPadding
            y: parent.height / 2 - height / 2
            radius: 13
            color: lightDarkMode.checked ? accent1color : "#D0D0D0"
            border.color: backgroundcolor2

            Rectangle {
                x: lightDarkMode.checked ? parent.width - width : 0
                width: 26
                height: 26
                radius: 13
                color: lightDarkMode.down ? "#CCCCCC" : "#FFFFFF"
                border.color: backgroundcolor2
            }
        }

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 5
            bottomMargin: 5
        }
    }

    Rectangle {
        id: fillerBorder

        anchors {
            top: demoWarning.bottom
            right: parent.right
            left: welcomeMsgRect.right
            bottom: lightDarkMode.top
            topMargin: 15
            leftMargin: 25
            rightMargin: 25
            bottomMargin: 10
        }

        radius: 20
        border.color: "#969696"
        color: "transparent"
        z: 3
    }

    Rectangle {
        id: filler

        anchors {
            top: demoWarning.bottom
            right: parent.right
            left: welcomeMsgRect.right
            bottom: lightDarkMode.top
            topMargin: 15
            leftMargin: 25
            rightMargin: 25
            bottomMargin: 10
        }

        //border.color: "#969696"
        color: backgroundcolor2
        radius: 20

        Component {
            id: savedDelegate
            Item {
                id: savedItem
                width: parent.width; height: 40
                Rectangle {
                    anchors.fill: parent
                    Text {
                        anchors {
                            right: parent.right
                            top: parent.top
                            rightMargin: 5
                            topMargin: 5
                        }


                    }
                }
            }
        }

        ListModel {
            id: savedModel
        }

        ListView {
            id: savedList
            anchors.fill: parent
            orientation: Qt.Vertical
            model: savedModel

            delegate: Item {
                width: parent.width; height: 45
                Rectangle {
                    anchors {
                        fill: parent
                        margins: 1
                    }

                    color: backgroundcolor

                    Text {
                        anchors {
                            left: parent.left
                            top: parent.top
                            leftMargin: 8
                            topMargin: 2
                        }

                        text: title
                        font.pixelSize: 19
                        color: textColor
                    }
                    Text {
                        anchors {
                            left: parent.left
                            bottom: parent.bottom
                            leftMargin: 8
                            topMargin: 5
                        }

                        text: type
                        font.pixelSize: 16
                        color: "#969696"
                    }

                    Button {
                        id: accessElement
                        anchors.fill: parent
                        enabled: isFocused
                        flat: true

                        background: Rectangle {
                            implicitWidth: parent.width
                            implicitHeight: parent.height
                            color: "transparent"
                        }

                        HoverHandler { cursorShape: Qt.PointingHandCursor }

                        onClicked: { inactiveTimer.restart()
                            viewSavedData(type, title, index)
                        }
                    }
                }
            }
        }

        Text {
            id: placeholderListText
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            text: "Saved items will appear here.\nSelect an item from the left menu to add it."
            color: textColor
            visible: savedList.count === 0 ? true : false
        }
    }


    function switchColorMode() {
        if(backgroundcolor == "#FFFFFF") {
            backgroundcolor = "#141414"
            backgroundcolor2 = "#242424"
            textColor = "#FFFFFF"
        }
        else {
            backgroundcolor = "#FFFFFF"
            backgroundcolor2 = "#D0D0D0"
            textColor = "#000000"
        }
    }

    function viewSavedData(type, title, idx) {
        if (type === "website") {
               // Ask C++ to emit websiteLoaded for this index
               console.log("Loading data at index", idx)
               DATABASE.loadWebsite(idx)

               isFocused = false
               backgroundRect.visible = true
               editWebsiteGUIFrame.visible = true
        }
        else if (type === "credit card") {
            console.log("Loading data at index", idx)
            DATABASE.loadCC(idx)

            isFocused = false
            backgroundRect.visible = true
            editCCGUIFrame.visible = true
        }
        else if (type === "ID card") {
            console.log("Loading data at index", idx)
            DATABASE.loadID(idx)

            isFocused = false
            backgroundRect.visible = true
            editIDGUIFrame.visible = true
        }
        else if (type === "secure note") {
            DATABASE.loadNote(idx)

            isFocused = false
            backgroundRect.visible = true
            editNoteGUIFrame.visible = true
        }
    }
}

