#ifndef MYCROFTCONTROL_H
#define MYCROFTCONTROL_H

#include <QObject>

class MyCroftControl : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRunning READ getRunning WRITE setRunning)

public:
    explicit MyCroftControl(QObject *parent = nullptr);

    bool isRunning;

    void setRunning(bool shallRun);
    bool getRunning();

signals:

public slots:
};

#endif // MYCROFTCONTROL_H
