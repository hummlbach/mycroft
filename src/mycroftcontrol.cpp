#include <iostream>
#include <fstream>

#include <QString>
#include <QProcess>
#include <QProcessEnvironment>
#include <QStringListIterator>

#include "mycroftcontrol.h"

const QString MYCROFT_CLICK_PATH = QStringLiteral("/opt/click.ubuntu.com/mycroft.hummlbach/current/");

const QString MYCROFT_DEPENDENCIES_PREFIX = MYCROFT_CLICK_PATH + QStringLiteral("mycroft-dependencies/");

const QString MYCROFT_DEPENDENCIES_BINS = MYCROFT_DEPENDENCIES_PREFIX + QStringLiteral("bin:")
                                        + MYCROFT_DEPENDENCIES_PREFIX + QStringLiteral("lib/git-core:");

const QString MYCROFT_DEPENDENCIES_LIBS = MYCROFT_DEPENDENCIES_PREFIX + QStringLiteral("lib/arm-linux-gnueabihf:") +
                                           MYCROFT_DEPENDENCIES_PREFIX + QStringLiteral("lib:");

const QString INSTALL_SCRIPT_PATH = MYCROFT_CLICK_PATH + QStringLiteral("scripts/ut_mycroft_installer.sh");

const QString MYCROFT_START_SCRIPT_PATH = MYCROFT_CLICK_PATH + QStringLiteral("scripts/ut_mycroft_launcher.sh");

const QString MYCROFT_CORE_PATH = QStringLiteral("/home/phablet/.local/share/mycroft.hummlbach/mycroft-core/");

//const QString MYCROFT_START_SCRIPT_PATH = MYCROFT_CORE_PATH + QStringLiteral("start-mycroft.sh");

const QString MYCROFT_STOP_SCRIPT_PATH = MYCROFT_CORE_PATH + QStringLiteral("stop-mycroft.sh");


MyCroftControl::MyCroftControl(QObject *parent = nullptr) : QObject(parent)
{
}


void MyCroftControl::setRunning(bool shallRun)
{
    isRunning = shallRun;
    if (shallRun)
    {
// setting the environment here would be far better than using an additional script
// but somehow setArguments seems not to work?!
//
//        QProcess process;
//        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
//        QString defaultPath = QString();
//        defaultPath = env.value("PATH");
//        env.insert("PATH", MYCROFT_DEPENDENCIES_BINS + defaultPath);
//        QString defaultLdLibraryPath = QString();
//        defaultLdLibraryPath = env.value("LD_LIBRARY_PATH");
//        env.insert("LD_LIBRARY_PATH", MYCROFT_DEPENDENCIES_LIBS + defaultLdLibraryPath);
//        env.insert("PULSE_CLIENTCONFIG", "/etc/pulse/touch-client.conf");
//        env.insert("PULSE_PLAYBACK_CORK_STALLED", "1");
//        env.insert("PULSE_PROP", "media.role=multimedia");
//        env.insert("PULSE_SCRIPT", "/etc/pulse/touch.pa");
//        QStringListIterator javaStyleIterator(env.toStringList());
//        std::ofstream myfile;
//        myfile.open ("/home/phablet/utmycroft.log");
//        while (javaStyleIterator.hasNext())
//            myfile << javaStyleIterator.next().toLocal8Bit().constData() << std::endl;
//        myfile.close();
//        process.setProcessEnvironment(env);
//        process.setWorkingDirectory(MYCROFT_CORE_PATH);
//        process.setArguments(QStringList("all"));
//        process.startDetached(MYCROFT_START_SCRIPT_PATH);
        QProcess::startDetached(MYCROFT_START_SCRIPT_PATH);
    }
    else
    {
        QProcess::startDetached(MYCROFT_STOP_SCRIPT_PATH);
    }
}


bool MyCroftControl::getRunning()
{
    return isRunning;
}
