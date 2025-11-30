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

    QString getURL() const;
    QString getUserName() const;
    QString getPassword();
};

class CreditCard : public ISecret {
private:
    const QString type = "credit card";
    QString name;
    QString cardNum;
    QString expDate;
    QString ccv;
    QString zipCode;

public:
    CreditCard(QString name, QString cardNum, QString expDate, QString ccv, QString zipCode);
    void notifyObservers() override;

    QString getName() const;
    QString getCardNum() const;
    QString getExpDate() const;
    QString getCcv() const;
    QString getZipCode() const;
};

class IDCard : public ISecret {
private:
    QString name;
    QString birthday;
    QString gender;
    QString height;
    QString address;

public:
    IDCard(QString name, QString birthday, QString gender, QString height, QString address);
    void notifyObservers() override;

    QString getName() const;
    QString getBirthday() const;
    QString getGender() const;
    QString getHeight() const;
    QString getAddress() const;
};

class SecureNote : public ISecret {
private:
    QString noteName;
    QString noteContent;

public:
    SecureNote(QString noteName, QString noteContent);
    void notifyObservers() override;

    QString getNoteName() const;
    QString getNoteContent() const;

};

#endif // SECRET_H
