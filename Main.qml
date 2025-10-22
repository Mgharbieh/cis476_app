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
        id: addnewItemContainer

        anchors {
            bottom: lightDarkMode.top
            left: parent.left
            bottomMargin: 10
            leftMargin: 30
        }

        width: 80
        height: 80
        radius: 40
        color: accent1color

        // NOT WORKING, WILL INVESTIGATE LATER //
        MultiEffect {
            anchors.fill: parent
            source: parent
            shadowEnabled: true
            shadowScale: 1.0
            shadowHorizontalOffset: 5
            shadowVerticalOffset: 5
            shadowColor: "#000000"
            shadowOpacity: 0.7
        }


        Rectangle {
            id: crossHorizontal

            anchors.centerIn: parent

            width: 50
            height: 5

            color: backgroundcolor
        }

        Rectangle {
            id: crossVertical

            anchors.centerIn: parent

            width: 5
            height: 50

            color: backgroundcolor
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
            top: parent.top
            right: parent.right
            left: addnewItemContainer.right
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

