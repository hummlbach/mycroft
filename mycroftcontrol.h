#ifndef MYCROFTCONTROL_H
#define MYCROFTCONTROL_H

#include <QObject>

class MyCroftControl : public QObject
{
    Q_OBJECT
public:
    explicit MyCroftControl(QObject *parent);

    void toggleOn();
    void toggleOff();

signals:

public slots:
};

#endif // MYCROFTCONTROL_H
