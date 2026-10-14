// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQml 2.15
import QtCore
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.15 as Kirigami
import org.kde.kquickcontrolsaddons as KQuickControlsAddons

Kirigami.ScrollablePage {
    id: bookPage
    property int minFontSize: 10
    property int maxFontSize: 30
    property string bookName: ""
    property int chapterCount: 0
    property string dataFile: ""
    property int selectedChapter: 1

    property ListModel versesModel: ListModel {}
    header: Kirigami.InlineMessage {
        id: clipboardMessage
        visible: false

        showCloseButton: true
        type: Kirigami.MessageType.Positive
    }

    Settings {
        id: settings
        category: "General"
        property int fontSize: 16
        property int alignment: Text.AlignLeft
    }

    function loadchapter(boo) {
        if (bookPage.dataFile === "")
            return;
        var xhr = new XMLHttpRequest();

        xhr.open("GET", Qt.resolvedUrl(bookPage.dataFile));
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && (xhr.status === 0 || xhr.status === 200)) {
                var json = JSON.parse(xhr.responseText);
                versesModel.clear();
                var chapter = json.book[boo - 1];
                for (var j = 0; j < chapter.verses.length; j++) {
                    var v = chapter.verses[j];

                    versesModel.append({
                        number: v.verse,
                        verse: v.text
                    });
                }
            }
        };
        xhr.send();
    }

    actions: [
        Kirigami.Action {
            text: "Align Left"
            icon.name: "align-horizontal-left"
            onTriggered: settings.alignment = Qt.AlignLeft
        },
        Kirigami.Action {
            text: "Align Center"
            icon.name: "align-horizontal-center"
            onTriggered: settings.alignment = Qt.AlignHCenter
        },
        Kirigami.Action {
            text: "Align Right"
            icon.name: "align-horizontal-right"
            onTriggered: settings.alignment = Qt.AlignRight
        },
        Kirigami.Action {
            separator: true
        },
        Kirigami.Action {
            text: "Bookmark"
            icon.name: "bookmarks"
            onTriggered: {
                applicationWindow().savePage(bookPage.bookName, bookPage.dataFile, bookPage.chapterCount, bookPage.selectedChapter);
                clipboardMessage.visible = true;
                clipboardMessage.text = "Saved to bookmarks";
            }
        },
        Kirigami.Action {
            separator: true
        },
        Kirigami.Action {
            icon.name: "zoom-in"
            shortcut: "Ctrl++"
            enabled: settings.fontSize < bookPage.maxFontSize
            onTriggered: {
                settings.fontSize += 2;
            }
        },
        Kirigami.Action {
            icon.name: "zoom-out"
            shortcut: "Ctrl+-"
            enabled: settings.fontSize > bookPage.minFontSize
            onTriggered: {
                settings.fontSize -= 2;
            }
        }
    ]

    Component.onCompleted: loadchapter(selectedChapter)

    ColumnLayout {
        id: contentLayout
        spacing: 20
        width: parent.width
        Kirigami.Heading {
            text: bookPage.bookName
            font.pointSize: 40
            font.bold: true
        }

        DefaultHeader {
            id: switcher
            alignment: settings.alignment
            chapterCount: bookPage.chapterCount
            selectedChapter: bookPage.selectedChapter
            onChapterRequested: chapterNumber => {
                bookPage.selectedChapter = chapterNumber;
                loadchapter(chapterNumber);
            }
        }

        Repeater {
            model: bookPage.versesModel
            Layout.preferredWidth: 400
            delegate: Controls.Button {
                id: customButton
                text: number + "  " + verse
                Layout.fillWidth: true
                background: Rectangle {
                    color: Kirigami.Theme.backgroundColor
                    radius: 4
                }

                contentItem: Text {
                    id: buttonText
                    text: `<font color="${Kirigami.Theme.textColor}">${number}</font>  <font color="${Kirigami.Theme.negativeTextColor}">${verse}</font>`
                    anchors.centerIn: parent
                    font.pointSize: settings.fontSize
                    horizontalAlignment: settings.alignment
                    wrapMode: Text.WordWrap
                    color: Kirigami.Theme.negativeTextColor

                    leftPadding: 20
                    verticalAlignment: Text.AlignVCenter
                }

                KQuickControlsAddons.Clipboard {
                    id: clipboard
                }
                onClicked: {
                    clipboard.content = customButton.text;
                    clipboardMessage.visible = true;
                    clipboardMessage.text = "Copied current verse!";
                }
            }
        }
    }
}
