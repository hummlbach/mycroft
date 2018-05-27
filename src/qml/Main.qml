import QtQuick 2.4
import Ubuntu.Components 1.3

MainView {
    applicationName: "mycroft.hummlbach"

    width: units.gu(100)
    height: units.gu(75)

    Page {
        header: PageHeader {
            id: pageHeader
            title: i18n.tr("MyCroft")
        }

        Label {
            id: label
            objectName: "label"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: pageHeader.bottom
                topMargin: units.gu(2)
            }

            text: i18n.tr("Experimental MyCroft package for Ubuntu Touch")
        }
    }
}
