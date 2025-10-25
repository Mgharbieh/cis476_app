import cis476_app

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Window {

    property string accent1color: "#144F85"
    property string backgroundcolor: "#FFFFFF"
    property string backgroundcolor2: "#D0D0D0"
    property string textColor: "#000000"

    property bool isFocused: true

    id: rootWindow
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Hello World")

    color: backgroundcolor

    LoginPage{
        id: loginPage
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
        height: 150
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
            topMargin: 10
            bottomMargin: 10
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
            topMargin: 15
            bottomMargin: 10
            leftMargin: 30
            rightMargin: 20
        }

        //border.color: "#000000"
        color: "transparent"

        Column {
            anchors.fill: parent
            spacing: 30

            Rectangle {
                id: websiteButton

                height: 100
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

                    onClicked: {
                        isFocused = false
                        backgroundRect.visible = true
                        websiteGUIFrame.visible = true
                    }
                }
            }

            Rectangle {
                id: creditCardButton

                height: 100
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
                }
            }

            Rectangle {
                id: identityButton

                height: 100
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
                }
            }

            Rectangle {
                id: secureNoteButton

                height: 100
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
                }
            }

            Rectangle {
                id: logoutButton

                height: 80
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

                    onClicked: {LOGIN.logout()}
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
    }

    Rectangle {
        id: websiteGUIFrame
        visible: false
        color: backgroundcolor
        radius: 20
        z: 3

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

        border.color: "#969696"
        color: backgroundcolor2
        radius: 20

        Component {
            id: savedDelegate
            Item {
                id: savedItem
                width: parent.width; height: 40
                Column {
                    Text { text: '<b>Name:</b> ' + myItem.name }
                }
            }
        }

        ListView {
            id: savedList
            anchors.fill: parent
            orientation: Qt.Vertical
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
}

