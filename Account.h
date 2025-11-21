#ifndef ACCOUNT_H
#define ACCOUNT_H

#include "Observer.h"
#include "passwordGenerator.h"
#include <QObject>
#include <QtQml>
#include <QString>

class Account : IObserver {
public:

    void update() override;


private:
    QString username;
    Password masterPassword;
    //vault
    //security question handlers
};

#endif // ACCOUNT_H
