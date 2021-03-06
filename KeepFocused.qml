import QtQuick 2.0
import Ubuntu.Components 0.1
import "ui"

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.andreap.keepfocused"

    width: units.gu(75)
    height: units.gu(110)

    headerColor: "#28589C"
    backgroundColor: "#00B7EB"
    //footerColor: "#00CCCC"

    Tabs {
        id: tabs

        GameTab {
            objectName: "gameTab"
        }

        SettingsTab {
            objectName: "settingsTab"
        }
    }
}
