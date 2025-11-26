#ifndef ACCOUNT_H
#define ACCOUNT_H

#include "Observer.h"
#include "passwordGenerator.h"
#include "SecurityQuestionHandler.h"
#include <QObject>
#include <QtQml>
#include <QString>
#include <vector>

class Account : public QObject, public IObserver {
    Q_OBJECT

public:

    SecurityQuestionHandler handler;
    std::vector<QString> questions;

    void update() override{}

    Account(){}

    ~Account(){}

    Account(QString username, QString password,
            QString q1, QString a1,
            QString q2, QString a2,
            QString q3, QString a3){

        handlers.push_back(new SecurityQuestionHandler(q1, a1));
        handlers.push_back(new SecurityQuestionHandler(q2, a2));
        handlers.push_back(new SecurityQuestionHandler(q3, a3));

        for(int i = 0; i < handlers.size() - 1; i++){
            handlers[i]->setSuccessor(handlers[i+1]);
        }

        questions.push_back(q1);
        questions.push_back(q2);
        questions.push_back(q3);

        this->handler = *handlers[0];

        this->username = username;
        this->masterPassword.setPass(password);
    }

    QString getPassword(){
        return masterPassword.getPassword();
    }

private:
    QString username;
    Password masterPassword;
    std::vector<SecurityQuestionHandler*> handlers;

};

#endif // ACCOUNT_H
