import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string noteName: ""
    property string noteText: ""

    id: note

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
            text: "Add Secure Note"

            font.pixelSize: 40
            font.bold: true
            color: rootWindow.textColor
        }
    }

    Rectangle {
        id: noteFrame
        visible: true
        color: "transparent"

        anchors {
            top: titleText.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 20
            leftMargin: 25
            rightMargin: 25
            bottomMargin: 20
        }

        TextField {
            id: secureNoteName
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignVCenter"
            leftPadding: 5

            placeholderText: "Name of note"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", secureNoteName.text)
             }
        }

        /*
        TextField {
            id: noteContent
            anchors {
                top: secureNoteName.bottom
                left: parent.left
                right: parent.right
                bottom: cancelButtonRect.top

                topMargin: 20
                rightMargin: 20
                leftMargin: 20
                bottomMargin: 20
            }

            echoMode: "Normal"
            font.pixelSize: 25
            color: rootWindow.textColor
            verticalAlignment: "AlignTop"
            leftPadding: 5

            placeholderText: "Enter note content"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                color: "transparent"
                border.color: "#969696"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", noteContent.text)
            }
        }

        */

        Rectangle {
            id: textEditRect

            anchors {
                top: secureNoteName.bottom
                left: secureNoteName.left
                right: secureNoteName.right
                bottom: cancelButtonRect.top

                topMargin: 15
                rightMargin: 0
                leftMargin: 0
                bottomMargin: 20
            }

            color: "transparent"
            border.color: "#969696"
            border.width: 1

            Text {
                id: placeholderText
                text: "Enter note..."
                color: "#B8B8B8"
                font.pixelSize: 18

                anchors {
                    top: parent.top
                    left: parent.left

                    topMargin: 5
                    leftMargin: 5
                }

                visible: noteContent.text === "" ? true : false

            }

            TextEdit {
                id: noteContent
                anchors.fill: parent

                font.pixelSize: 20
                color: rootWindow.textColor
                verticalAlignment: "AlignTop"
                padding: 5
                wrapMode: TextEdit.WordWrap

                //placeholderText: "Enter note content"
                //placeholderTextColor: "#B8B8B8"

                onEditingFinished: {
                    //debugging
                    console.log("Input finished:", noteContent.text)
                }
            }
        }

        Rectangle {
            id: missingFieldRect

            height: parent.height * 0.10
            width: parent.width * 0.40

            anchors {
                bottom: textEditRect.bottom
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }

            z: 4
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
                id: saveContent
                anchors.fill: parent
                //enabled: isFocused

                text: "Save"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: saveContent.text
                    font: saveContent.font
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
                    // ADD SAVE FUNCTIONALITY HERE ONCE DATABASE IS IMPLEMENTED //
                    var incomplete = false
                    if(secureNoteName.text == "")
                    {
                        secureNoteName.background.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false) {
                        note.parent.visible = false
                        focusBackground.visible = false
                        rootWindow.isFocused = true
                        secureNoteName.background.border.color = "#969696"
                        missingFieldRect.visible = false
                    }
                    else {
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
                bottom: noteFrame.bottom

                rightMargin: parent.width * 0.02
                bottomMargin: parent.height * 0.02
            }

            Button {
                id: cancelNote
                anchors.fill: parent
                //enabled: isFocused

                text: "Cancel"
                font.pixelSize: 25
                font.bold: true
                flat: true

                contentItem: Text {
                    anchors.centerIn: parent
                    text: cancelNote.text
                    font: cancelNote.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "#FFFFFF"
                }

                /*
                background: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    color: "transparent"
                }
                */

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: {
                    noteContent.text = ""
                    secureNoteName.text = ""
                    note.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true
                    secureNoteName.background.border.color = "#969696"
                    missingFieldRect.visible = false
                }
            }
        }
    }
}
