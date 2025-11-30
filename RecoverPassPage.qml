import cis476_app

import QtQuick
import QtQuick.Controls

Item {
    id: recoverScreen
    anchors.fill: parent
    visible: false
    z: 101

    onVisibleChanged: questionText.text = LOGIN.getQuestion(0)

    property string currentAnswer: ""
    property int numSecurityQuestions: 3
    property int currentQuestionIndex: 0

    // Signals to C++ or parent QML
    signal backToLoginRequested()
    signal answerSubmitted(string answer)


    Rectangle {
        id: panel
        width: 600
        height: 260
        radius: 10
        color: "#FFFFFF"
        border.color: "#144F85"
        anchors.centerIn: parent

        Column {
            anchors.fill: parent
            anchors.margins: 24
            spacing: 16

            Text {
                text: "Account Recovery"
                font.pixelSize: 26
                font.bold: true
                color: "#144F85"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: questionText
                text: ""
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                wrapMode: Text.WordWrap
            }


            TextField {
                id: answerField
                placeholderText: "Enter your answer"
                text: recoverScreen.currentAnswer
                onTextChanged: recoverScreen.currentAnswer = text
            }

            Row {
                spacing: 16
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Back to Login"
                    onClicked: {
                        submitButton.enabled = true
                        recoverScreen.backToLoginRequested()
                    }
                }

                Button {
                    id: submitButton
                    text: "Submit Answer"
                    onClicked: { inactiveTimer.restart()
                        var questionIndex = LOGIN.submitResponse(questionText.text, answerField.text)
                        if(questionIndex === currentQuestionIndex){
                            statusText.text = "Incorrect, try again"
                        }
                        else{
                            statusText.text = ""
                            answerField.text = ""
                        }
                        currentQuestionIndex = questionIndex

                        questionText.text = LOGIN.getQuestion(questionIndex)
                        if(questionIndex >= numSecurityQuestions){
                            currentQuestionIndex = 0
                            questionText.text = "MASTER PASSWORD: " + LOGIN.getPassword()
                            submitButton.enabled = false
                        }
                    }
                }

                // New Text element
                Text {
                    id: statusText
                    text: ""
                    color: "red"
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }
        }
    }
}
