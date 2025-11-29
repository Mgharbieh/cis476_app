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

    bool hasDigit = false;
    bool hasUpper = false;
    bool hasLower = false;

    for (QChar c : password) {
        if (c.isDigit())      hasDigit = true;
        else if (c.isUpper()) hasUpper = true;
        else if (c.isLower()) hasLower = true;
    }

    bool isWeak = (password.length() < 8 ||
                   !hasDigit || !hasUpper || !hasLower);

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
    if (!_handler)
        return;

    // handle CreditCard, IDCard, etc.
    // e.g., dynamic_cast<CreditCard*>(subject) and check expiration.

    // Example pseudo-code:
    // if (auto* card = dynamic_cast<CreditCard*>(subject)) {
    //     if (card->isExpired()) {
    //         m_handler->reportExpiryIssue(subject);
    //     }
    // }
}
