import QtQuick 2.0
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components 0.1
import QtQuick.LocalStorage 2.0
import "../components"
import "../JS/preferences.js" as Preferences

Tab {
    title: i18n.tr("Settings")

    onVisibleChanged: recordLabel.text = Preferences.get("CURRENTRECORD", 0)

    Component {
        id: dialog
        Dialog {
            id: dialogue
            title: i18n.tr("Are you sure?")
            Button {
                text: i18n.tr("Yes")
                onClicked: {
                    Preferences.set("CURRENTRECORD", "0")
                    recordLabel.text = Preferences.get("CURRENTRECORD", 0)
                    PopupUtils.close(dialogue)
                }
            }
            Button {
                text: i18n.tr("Cancel")
                color: UbuntuColors.orange
                onClicked: PopupUtils.close(dialogue)
            }
        }
    }

    page: Page {
        Column {
            spacing: units.gu(2)
            anchors.centerIn: parent

            Label {
                text: i18n.tr("Interval between two colors: %1 seconds").arg(parseInt(liveSlider.value)/10)
                font.weight: Font.Light
                anchors {horizontalCenter: parent.horizontalCenter }
            }

            Slider {
                id: liveSlider
                objectName: "slider_live"
                live: true
                value: parseInt(Preferences.get("INTERVAL",2000))/100
                minimumValue: 6; maximumValue: 20;
                anchors {horizontalCenter: parent.horizontalCenter }

                onValueChanged: Preferences.set("INTERVAL", parseInt(liveSlider.value)*100)
            }

            Label {
                text: i18n.tr("Current Record:")
                font.weight: Font.Light
                anchors {horizontalCenter: parent.horizontalCenter }
            }

            Label {
                id: recordLabel
                text: Preferences.get("CURRENTRECORD", 0)
                font.weight: Font.Bold
                fontSize: "x-large"
                anchors {horizontalCenter: parent.horizontalCenter }
            }

            Button {
                text: i18n.tr("Delete Record")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width*0.75
                onClicked: PopupUtils.open(dialog)
            }
        }
    }
}
