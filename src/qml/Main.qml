import QtQuick 2.15
import org.kde.kirigami as Kirigami
import org.wesen.bible

Kirigami.ApplicationWindow {
    id: root

    visible: true
    minimumWidth: 980
    minimumHeight: 500
    width: Screen.width
    height: Screen.height

    title: "Amharic Bible"
    property var textSize: 12

    globalDrawer: Kirigami.GlobalDrawer {
        isMenu: true
        actions: [
            Kirigami.Action {
                text: i18n("About")
                icon.name: "help-about"
                onTriggered: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            },
            Kirigami.Action {
                text: "Quit"
                icon.name: "application-exit"
                shortcut: "Ctrl+Q"
                onTriggered: Qt.quit()
            }
        ]
    }

    pageStack.defaultColumnWidth: width
    pageStack.initialPage: WelcomePage {}
}
