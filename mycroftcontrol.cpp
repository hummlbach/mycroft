#include <QString>
#include <QProcess>

#include "mycroftcontrol.h"

const QString MYCROFT_START_SCRIPT_PATH = QStringLiteral("/opt/click.ubuntu.com/mycroft.hummlbach/current/scripts/ut_mycroft_launcher.sh");
const QString MYCROFT_STOP_SCRIPT_PATH = QStringLiteral("/home/phablet/.local/share/mycroft.hummlbach/mycroft-core/stop-mycroft.sh");

const QString INSTALL_SCRIPT_PATH = QStringLiteral("/opt/click.ubuntu.com/mycroft.hummlbach/current/");

MyCroftControl::MyCroftControl(QObject *parent) : QObject(parent)
{
}

void MyCroftControl::toggleOn()
{
    QProcess::startDetached(MYCROFT_START_SCRIPT_PATH);
}

void MyCroftControl::toggleOff()
{
    QProcess::startDetached(MYCROFT_STOP_SCRIPT_PATH);
}

