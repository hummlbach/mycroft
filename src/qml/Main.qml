import QtQuick 2.4
import QtQuick.Layouts 1.0
import Ubuntu.Components 1.3
import utmycroft.mycroftcontrol 1.0

MainView {
    applicationName: "mycroft.hummlbach"

    width: units.gu(100)

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("MyCroft")
        }

        Item {
            anchors {
                top: pageHeader.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: units.gu(1)
            }

            ColumnLayout {
                anchors.fill: parent

                spacing: units.gu(1)

                RowLayout {
                    spacing: units.gu(1)

                    Label {
                        Layout.fillWidth: true
                        text: i18n.tr("Turn MyCroft %1".arg(toggleSwitch.checked ? "off" : "on"))
                        wrapMode: Text.WordWrap
                    }

                    Switch {
                        id: toggleSwitch
                        checked: false
                        onCheckedChanged: backend.isRunning = checked
                    }

                    MyCroftControl {
                        id: backend
                    }
                }

                Item { Layout.fillHeight: true }    // Spacer
            }
        }
    }

    Page {
        visible: false

        header: PageHeader {
            id: pageHeader1
            title: i18n.tr("MyCroft - Installing")
        }

        Item {
            anchors {
                top: pageHeader1.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: units.gu(1)
            }

            ColumnLayout {
                anchors.fill: parent

                spacing: units.gu(1)

                Label {
                    Layout.fillWidth: true
                    text: i18n.tr("Preparing your installation ...")
                    wrapMode: Text.WordWrap
                }

                Label {
                    Layout.fillWidth: true
                    text: i18n.tr("Please don't interrupt this process!")
                    font.bold: true
                    wrapMode: Text.WordWrap
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ActivityIndicator {
                        anchors.centerIn: parent
                        running: true
                    }
                }
            }
        }
    }

}
