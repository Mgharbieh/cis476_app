import cis476_app

import QtQuick
import QtQuick.Controls

Window {
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Hello World")

    LoginPage{
        id: loginPage
    }

    Rectangle {
        id: filler

        width: 300
        height: 100
        anchors.centerIn: parent
        border.color: "#000000"
        border.width: 2

        Text {
            text: "idk do something here"
            anchors.centerIn: parent

            wrapMode: Text.WordWrap
            font.pixelSize: 18
            color: "#000000"
        }
    }
}
