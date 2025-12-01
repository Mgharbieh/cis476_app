import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    property string noteName: ""
    property string noteText: ""

    property int currentItem: -1
    property bool editable: false
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
            id: secureNoteNameInput
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
            enabled: editable

            placeholderText: "Name of note"
            placeholderTextColor: "#B8B8B8"

            background: Rectangle {
                id: secureNoteNameInputRect
                color: "transparent"
                border.color: editable == true ? "#969696" : "transparent"
                border.width: 1
            }

            onEditingFinished: {
                //debugging
                console.log("Input finished:", secureNoteNameInput.text)
             }
        }

        Rectangle {
            id: textEditRect

            anchors {
                top: secureNoteNameInput.bottom
                left: secureNoteNameInput.left
                right: secureNoteNameInput.right
                bottom: cancelButtonRect.top

                topMargin: 15
                rightMargin: 0
                leftMargin: 0
                bottomMargin: 20
            }

            color: "transparent"
            border.color: editable == true ? "#969696" : "transparent"
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
                enabled: editable

                onEditingFinished: {
                    //debugging
                    console.log("Input finished:", noteContent.text)
                    textEditRect.border.color = "#969696"
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
            color: "#30FF0000" // 30 is alpha value

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

                text: editable === true ? "Update" : "Edit"
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

                onClicked: { inactiveTimer.restart()
                    // ADD SAVE FUNCTIONALITY HERE ONCE DATABASE IS IMPLEMENTED //
                    var incomplete = false
                    if(secureNoteNameInput.text == "") {
                        secureNoteNameInputRect.background.border.color = "#FF0000"
                        incomplete = true
                    }
                    if(noteContent.text == "") {
                        textEditRect.border.color = "#FF0000"
                        incomplete = true
                    }

                    if(incomplete == false) {
                        if(editable === false) {
                            textEditRect.border.color = "#969696"
                            secureNoteNameInputRect.border.color = "#969696"
                            editable = true
                        }
                        else if(editable === true) {
                            var changed = false
                            if(secureNoteNameInput.text !== noteName) {
                                DATABASE.updateField(currentItem, "secure note", noteName, "title", secureNoteNameInput.text)
                                changed = true
                            }
                            if(noteContent.text !== noteText) {
                                DATABASE.updateField(currentItem, "secure note", noteName, "note", noteContent.text)
                                changed = true
                            }
                            if(changed === true) {
                                DATABASE.updateNote(currentItem, secureNoteNameInput.text, noteContent.text)
                            }

                            note.parent.visible = false
                            focusBackground.visible = false
                            rootWindow.isFocused = true
                            secureNoteNameInputRect.border.color = "transparent"
                            textEditRect.border.color = "transparent"
                            missingFieldRect.visible = false
                        }
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
            color: accent1color

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

                HoverHandler { cursorShape: Qt.PointingHandCursor }

                onClicked: { inactiveTimer.restart()
                    noteContent.text = ""
                    secureNoteNameInput.text = ""
                    note.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true
                    secureNoteNameInputRect.border.color = "transparent"
                    textEditRect.border.color = "transparent"
                    editable = false
                    missingFieldRect.visible = false
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
                bottom: noteFrame.bottom

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
                    secureNoteNameInputRect.border.color = "transparent"
                    textEditRect.border.color = "transparent"

                    secureNoteNameInput.text = ""
                    noteContent.text = ""

                    note.parent.visible = false
                    focusBackground.visible = false
                    rootWindow.isFocused = true
                    missingFieldRect.visible = false

                    savedModel.clear()
                    DATABASE.deleteItem(currentItem, "secure note", "title", noteName)

                    missingFieldRect.visible = false
                    editable = false
                }
            }
        }
    }

    function populateUI(_idx, _name, _text) {
        currentItem = _idx

        secureNoteNameInput.text = _name
        noteContent.text = _text

        noteName = _name
        noteText = _text
    }
}
