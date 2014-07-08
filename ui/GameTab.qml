import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 0.1
import "../components"
import "../JS/preferences.js" as Preferences

Tab {
    title: i18n.tr("Keep Focused")

    property int rectD: 10
    property int currentColor
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
            //animateColor(firstImageView);
            break;
        case 1:
            rect2.color = color
            rect1.color = basicColor
            rect3.color = basicColor
            //animateColor(secondImageView);
            break;
        case 2:
            rect3.color = color
            rect2.color = basicColor
            rect1.color = basicColor
            //animateColor(thirdImageView);
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
        console.log("currentColor: " + currentColor + " i: " + i)
        if (currentColor === i) {
            currentScoreText.text = (parseInt(currentScoreText.text) + 1);
            //correctAnswer = true;
            //disenable(false);
        } else {
            //gameOver();
        }
    }

    Timer {
        interval: Preferences.get("INTERVAL",1000); running: true; repeat: true
        onTriggered: {
            setUpColors()
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
            height: units.gu(rectD + (rectD/2))
            spacing: units.gu(5)

            Rectangle {
                id:rect1
                height: units.gu(rectD)
                width: units.gu(rectD)
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: units.gu(rectD/2)
            }

            Rectangle {
                id:rect2
                height: units.gu(rectD)
                width: units.gu(rectD)
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: units.gu(rectD/2)
            }

            Rectangle {
                id:rect3
                height: units.gu(rectD)
                width: units.gu(rectD)
                color: basicColor
                anchors.verticalCenter: parent.verticalCenter
                radius: units.gu(rectD/2)
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
                color: colors[0]
                height: root.width/5; width: root.width/5
                onClicked: click(0)
            }

            Button {
                color: colors[1]
                height: root.width/5; width: root.width/5
                onClicked: click(1)
            }

            Button {
                color: colors[2]
                height: root.width/5; width: root.width/5
                onClicked: click(2)
            }
        }
        tools: ToolbarItems {
            ToolbarButton {
                text: i18n.tr("New Game")
                iconSource: "../graphics/new_game.svg"
                //onTriggered:
            }
        }
    }

}
