import cis476_app

import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Window {

    property string accent1color: "#144F85"
    property string backgroundcolor: "#FFFFFF"
    property string textColor: "#000000"

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

        width: 250
        height: 120
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
        id: buttonMenu

        anchors {
            top: welcomeMsgRect.bottom
            bottom: lightDarkMode.top
            left: parent.left
            right: filler.left
            topMargin: 5
            bottomMargin: 10
            leftMargin: 30
            rightMargin: 20
        }

        border.color: "#000000"

        Column {
            spacing: 10

            Rectangle {
                id: websiteLoginButton

                height: 40
                width: parent.width
                radius: 10

                Button {
                    anchors.fill: parentjf
                }
            }
        }
    }

    Switch {
        id: lightDarkMode
        onClicked: switchColorMode()

        height: 20
        width: 60

        background: {
            color: lightDarkMode.checked ? accent1color : "#FFFFFF"
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
        color: "#D0D0D0"
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
            text: "Saved items will appear here\nClick the '+' to add a new item"
            visible: savedList.count === 0 ? true : false
        }
    }


    function switchColorMode() {
        if(backgroundcolor == "#FFFFFF") {
            backgroundcolor = "#141414"
            textColor = "#FFFFFF"
        }
        else {
            backgroundcolor = "#FFFFFF"
            textColor = "#000000"
        }
    }
}

