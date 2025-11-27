#ifndef SECRET_H
#define SECRET_H

#include "Observer.h"
#include "passwordGenerator.h"
#include <QObject>
#include <QtQml>
#include <QString>
#include <vector>
#include <algorithm>

class ISecret {
public:
    virtual ~ISecret() = default;

    virtual void registerObserver(IObserver* observer){
        observers_.push_back(observer);
    }

    virtual void removeObserver(IObserver* observer){
        observers_.erase(std::remove(observers_.begin(), observers_.end(), observer), observers_.end());
    }

    virtual void notifyObservers() = 0;

protected:
    std::vector<IObserver*> observers_;
};

class Website : public ISecret{
private:
    const QString type = "website";
    QString url;
    QString username;
    Password password = Password();

public:
    Website(QString url, QString username, QString password);
    void notifyObservers() override;
    QString getURL();
    QString getUserName();
    QString getPassword();
};

#endif // SECRET_H
