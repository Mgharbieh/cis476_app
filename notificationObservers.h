#ifndef NOTIFICATIONOBSERVERS_H
#define NOTIFICATIONOBSERVERS_H


#include "Observer.h"

class DatabaseHandler;
class Website;


// Weak password observer
class WeakPasswordObserver : public IObserver {
public:
    explicit WeakPasswordObserver(DatabaseHandler* handler) : _handler(handler) {}

void update(ISecret* subject) override;

private:
    DatabaseHandler* _handler;
};


//Expiration Observer
class ExpirationObserver : public IObserver {
public:
    explicit ExpirationObserver(DatabaseHandler* handler) : _handler(handler) {}

    void update(ISecret* subject) override;

private:
    DatabaseHandler* _handler;
};





#endif // NOTIFICATIONOBSERVERS_H
