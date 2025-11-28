#include "notificationObservers.h"
#include "Secret.h"
#include "databasehandler.h"

#include <QDate>


void WeakPasswordObserver::update(ISecret* subject){

    Website* website = dynamic_cast<Website*>(subject);
    if(!website || !_handler){ return;}

    const QString password = website->getPassword();

    bool hasDigit = false;
    for (QChar c : password) {
             if (c.isDigit()){
                 hasDigit = true;
                 break;
             }
         }

    bool isWeak = password.length() < 8 || hasDigit == false;

         if(isWeak){
        _handler->reportWeakPassword(subject);
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
