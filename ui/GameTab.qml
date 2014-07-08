import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components 0.1
import "../components"
import "../JS/preferences.js" as Preferences

Tab {
    title: i18n.tr("Keep Focused")

    property int rectD: 10
    property int currentColor
    property int threshold: units.gu(20)
    property int threshold2: units.gu(15)
    property bool correctAnswer: true
    property string basicColor: "#DBE9F4"
    property var colors: ['#007FFF', '#D3212D', '#008000']

    function setUpColors() {
        var index = Math.floor((Math.random() * 3));
        var color = setColorId(Math.floor((Math.random() * 3)));

        switch (index) {
        case 0:
            rect1.color = color
            rect2.color = basicColor
            rect3.color = basicColor
            rect1animation.running = true
            break;
        case 1:
            rect2.color = color
            rect1.color = basicColor
            rect3.color = basicColor
            rect2animation.running = true
            break;
        case 2:
            rect3.color = color
            rect2.color = basicColor
            rect1.color = basicColor
            rect3animation.running = true
            break;
        }
    }

    function restoreColors() {
        rect1.color = basicColor
        rect2.color = basicColor
        rect3.color = basicColor
    }

    function setColorId(i) {
        currentColor = i
        return colors[i]
    }

    function click(i) {
        if (currentColor === i) {
            currentScoreText.text = (parseInt(currentScoreText.text) + 1);
            correctAnswer = true;
            disenable(0);
        } else {
            gameOver();
        }
    }

    function gameOver() {
        disenable(0)
        correctAnswer = false;
        timer.running = false
        restoreColors()
        PopupUtils.open(dialog)
    }

    function disenable(way) {
        button0.enabled = way
        button1.enabled = way
        button2.enabled = way
    }

    Timer {
        id: timer
        interval: Preferences.get("INTERVAL",2000);
        running: false;
        repeat: true
        onTriggered: {
            if(!correctAnswer) {
                gameOver()
            } else {
                correctAnswer = false
                setUpColors()
                disenable(1)
            }
        }
    }

    Component {
        id: dialog
        Dialog {
            id: dialogue
            title: i18n.tr("You lose")
            Button {
                text: i18n.tr("Try Again")
                onClicked: {
                    timer.running = true
                    correctAnswer = true;
                    disenable(1)
                    PopupUtils.close(dialogue)
                }
            }
            Button {
                text: i18n.tr("Cancel")
                color: UbuntuColors.orange
                onClicked: PopupUtils.close(dialogue)
            }

            Component.onCompleted: {
                if(parseInt(currentScoreText.text) > Preferences.get("RECORD", 0))
                    dialogue.text = "Whoa! "+ parseInt(currentScoreText.text) + " is your new Record!"
                currentScoreText.text = "0"
            }
        }
    }

    page: Page {
        id: root

        Row {
            id: targetRow
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: units.gu(2)
            }
            height:  units.gu(rectD + (rectD/2))
            spacing: units.gu(5)

            Rectangle {
                id:rect1
                height: (root.width/6 < threshold2) ? root.width/6 : threshold2;
                width: height
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: height/2

                SequentialAnimation on border.width {
                    id: rect1animation
                    running: false
                    PropertyAnimation { to: 2 }
                    PropertyAnimation { to: 0 }
                }
            }

            Rectangle {
                id:rect2
                height: (root.width/6 < threshold2) ? root.width/6 : threshold2;
                width: height
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: height/2

                SequentialAnimation on border.width {
                    id: rect2animation
                    running: false
                    PropertyAnimation { to: 2 }
                    PropertyAnimation { to: 0 }
                }
            }

            Rectangle {
                id:rect3
                height: (root.width/6 < threshold2) ? root.width/6 : threshold2;
                width: height
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: height/2

                SequentialAnimation on border.width {
                    id: rect3animation
                    running: false
                    PropertyAnimation { to: 2 }
                    PropertyAnimation { to: 0 }
                }
            }
        }

        Text {
            id: currentScoreText
            color: "white"
            anchors.centerIn: parent
            font.pixelSize: (buttonsRow.y - targetRow.y) /2
            text: "0"
        }

        Row {
            id: buttonsRow
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: units.gu(3)
            }
            spacing: units.gu(5)

            Button {
                id: button0
                color: colors[0]
                height: (root.width/5 < threshold) ? root.width/5 : threshold;
                width: height
                onClicked: click(0)
            }

            Button {
                id: button1
                color: colors[1]
                height: (root.width/5 < threshold) ? root.width/5 : threshold;
                width: height
                onClicked: click(1)
            }

            Button {
                id: button2
                color: colors[2]
                height: (root.width/5 < threshold) ? root.width/5 : threshold;
                width: height
                onClicked: click(2)
            }
        }
        tools: ToolbarItems {
            ToolbarButton {
                text: i18n.tr("New Game")
                iconSource: "../graphics/new_game.svg"
                onTriggered: {
                    correctAnswer = true;
                    timer.running = true
                    disenable(1)
                }
            }
        }
    }

}
