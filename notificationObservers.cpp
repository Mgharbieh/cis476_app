#include "notificationObservers.h"
#include "Secret.h"
#include "databasehandler.h"

#include <QDate>


void WeakPasswordObserver::update(ISecret* subject){

    Website* website = dynamic_cast<Website*>(subject);
    if(!website || !_handler){ return;}

    const QString password = website->getPassword();

    qDebug() << "[WeakPasswordObserver] Checking website"
             << website->getURL()
             << "password:" << password;

    bool hasUpper = false;
    bool hasLower = false;

    for (QChar c : password) {
        if (c.isUpper()) hasUpper = true;
        else if (c.isLower()) hasLower = true;
    }

    bool isWeak = (password.length() < 8 || !hasUpper || !hasLower);

    if (isWeak) {
        qDebug() << "[WeakPasswordObserver] WEAK password detected for"
                 << website->getURL();
        _handler->reportWeakPassword(subject);
    } else {
        qDebug() << "[WeakPasswordObserver] Password OK for"
                 << website->getURL();
    }
}

void ExpirationObserver::update(ISecret* subject)
{

    CreditCard* creditcard = dynamic_cast<CreditCard*>(subject);
    if( !_handler || !creditcard){return;}

    if(creditcard->isExpired()){
        qDebug() << "[ExpirationObserver] expired date found"
                 << creditcard->getExpDate();

        _handler->reportExpiryIssue(subject);
    }
    else{
        qDebug() << "[ExpirationObserver] Card is not expired"
                 << creditcard->getExpDate();
    }
}
