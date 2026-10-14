// SPDX-FileCopyrightText: 2026 Abenezer Wesenseged <wseged@proton.me>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Item {
    id: headerRoot
    property int chapterCount: 0
    property int selectedChapter: 1
    property int alignment: Text.AlignLeft

    signal chapterRequested(int chapterNumber)
    implicitHeight: contentLayout.implicitHeight
    Layout.fillWidth: true
    Layout.fillHeight: true

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        spacing: 20

        GridLayout {
            columns: applicationWindow().width > 1100 ? 23 : 17
            columnSpacing: 4
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                id: chapterRepeater
                model: headerRoot.chapterCount
                delegate: Controls.Button {
                    id: chapterBtn
                    text: index + 1
                    width: 40
                    height: 36
                    hoverEnabled: true

                    background: Rectangle {
                        color: chapterBtn.hovered ? Kirigami.Theme.negativeTextColor : (headerRoot.selectedChapter === index + 1 ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.backgroundColor)
                        radius: 6
                        Controls.Label {
                            anchors.centerIn: parent
                            text: i18n("%1", index + 1)
                            font.pointSize: 8
                            color: chapterBtn.hovered ? Kirigami.Theme.textColor : (headerRoot.selectedChapter === index + 1 ? Kirigami.Theme.textColor : Kirigami.Theme.negativeTextColor)
                        }
                    }

                    onClicked: {
                        headerRoot.selectedChapter = index + 1;
                        headerRoot.chapterRequested(headerRoot.selectedChapter);
                    }
                }
            }
        }

        Kirigami.Heading {
            text: i18n("ምዕራፍ %1", headerRoot.selectedChapter)
            font.pointSize: 24
            Layout.alignment: headerRoot.alignment
        }
    }
}
