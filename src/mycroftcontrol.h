#ifndef MYCROFTCONTROL_H
#define MYCROFTCONTROL_H

#include <QObject>
#include <QProcess>

class MyCroftControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRunning READ getRunning WRITE setRunning)
    Q_PROPERTY(bool isInstalled READ install)

public:
    explicit MyCroftControl(QObject *parent = nullptr);

    bool isRunning;
    bool isInstalled;
    QProcess installer;

    void setRunning(bool shallRun);
    bool getRunning();
    bool install();

signals:
    void installFinished();

public slots:
    void onFinishedProxy();
};

#endif // MYCROFTCONTROL_H
