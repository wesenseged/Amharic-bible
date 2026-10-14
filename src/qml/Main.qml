// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtCore
import QtQuick 2.15
import org.kde.kirigami as Kirigami
import QtQuick.Layouts 1.15
import QtQuick.Controls as QQC2

Kirigami.ApplicationWindow {
    id: root

    visible: true
    minimumWidth: 800
    minimumHeight: 500
    width: Screen.width
    height: Screen.height

    Settings {
        id: settings

        property string savedBookmarks: "[]"
    }

    title: "Amharic Bible"

    ListModel {
        id: pinnedModel
    }

    function saveBookmarks() {
        var bookmarks = [];

        for (var i = 0; i < pinnedModel.count; ++i) {
            var item = pinnedModel.get(i);
            bookmarks.push({
                bookName: item.bookName,
                dataFile: item.dataFile,
                chapterCount: item.chapterCount,
                selectedChapter: item.selectedChapter
            });
        }

        settings.savedBookmarks = JSON.stringify(bookmarks);
    }

    function loadBookmarks() {
        pinnedModel.clear();

        var bookmarks = JSON.parse(settings.savedBookmarks);

        for (var i = 0; i < bookmarks.length; ++i) {
            pinnedModel.append({
                bookName: bookmarks[i].bookName,
                dataFile: bookmarks[i].dataFile,
                chapterCount: bookmarks[i].chapterCount || 0,
                selectedChapter: bookmarks[i].selectedChapter
            });
        }
    }

    function savePage(bookName, dataFile, chapterCount, selectedChapter) {
        pinnedModel.append({
            bookName: bookName,
            dataFile: dataFile,
            chapterCount: chapterCount,
            selectedChapter: selectedChapter
        });

        saveBookmarks();
    }

    Component.onCompleted: {
        loadBookmarks();
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: globalDrawer
        width: 300
        title: "Bookmarks"
        titleIcon: "bookmarks"

        ListView {
            id: pinnedView
            model: pinnedModel
            implicitHeight: 800
            spacing: Kirigami.Units.largeSpacing
            Layout.fillWidth: true
            Layout.fillHeight: true
            delegate: Kirigami.AbstractCard {
                id: pinnedCard
                Layout.fillWidth: true
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("BookPage.qml"), {
                        bookName: model.bookName,
                        chapterCount: model.chapterCount,
                        dataFile: model.dataFile,
                        selectedChapter: model.selectedChapter
                    });
                    globalDrawer.close();
                }
                contentItem: ColumnLayout {
                    Kirigami.Heading {
                        text: model.bookName
                    }
                    Kirigami.Separator {
                        Layout.fillWidth: true
                    }
                    RowLayout {
                        QQC2.Label {
                            text: "ምዕራፍ " + model.selectedChapter
                        }
                        Kirigami.Padding {
                            Layout.fillWidth: true
                        }
                        QQC2.Button {
                            icon.name: "edit-delete"
                            onClicked: {
                                pinnedModel.remove(index);
                                saveBookmarks();
                            }
                        }
                    }
                }
            }
        }

        QQC2.Button {
            text: i18n("About")
            icon.name: "help-about"
            Layout.fillWidth: true
            onClicked: {
                pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
                globalDrawer.close();
            }
        }
        QQC2.Button {
            text: i18n("Quit")
            icon.name: "application-exit"
            Layout.fillWidth: true
            onClicked: Qt.quit()
        }
    }

    pageStack.defaultColumnWidth: width
    pageStack.initialPage: WelcomePage {}
}
