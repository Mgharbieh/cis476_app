#include "Secret.h"
#include <QDate>
//TODO: Implement all secrets here

Website::Website(QString url, QString username, QString password){
    this->url = url;
    this->username = username;
    this->password.setPass(password);
}

void Website::notifyObservers(){
    for (auto* obs : observers_){
        if(obs){
            obs->update(this);
        }
    }
}

QString Website::getURL() const { return url; }
QString Website::getUserName() const { return username; }
QString Website::getPassword() {return password.getPassword(); }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CreditCard::CreditCard(QString name, QString cardNum, QString expDate, QString ccv, QString zipCode)
{
    this->name = name;
    this->cardNum = cardNum;
    this->expDate = expDate;
    this->ccv = ccv;
    this->zipCode = zipCode;
}

void CreditCard::notifyObservers(){
    for (auto* obs : observers_){
        if(obs){
            obs->update(this);
        }
    }
}

bool CreditCard::isExpired(){

    QString exp = this->expDate;

    // Split the string into Month and Year parts (e.g., "12/30" -> "12" and "30")
    QStringList parts = exp.split('/');

    if (parts.count() != 2) {
        qDebug() << "Error: Invalid input format, expected mm/yy.";
        return true; // Treat invalid input as expired/problematic
    }

    int month = parts[0].toInt();
    int twoDigitYear = parts[1].toInt();

    int fullYear = 2000 + twoDigitYear;

    QDate expirationDate(fullYear, month, 1);

    if (!expirationDate.isValid()) {
        qDebug() << "Error: Invalid month/year combination:" << exp;
        return true;
    }

    // Compare the expiration date with today's date
    QDate today = QDate::currentDate();

    if(expirationDate < today){
        return true; // Date is expired
    }
    else{
        return false; // Not expired
    }

}

QString CreditCard::getCardNum() const { return cardNum; }
QString CreditCard::getExpDate() const { return expDate; }
QString CreditCard::getCcv() const { return ccv; }
QString CreditCard::getZipCode() const { return zipCode; }
QString CreditCard::getName() const { return name; }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

IDCard::IDCard(QString name, QString birthday, QString gender, QString height, QString address)
{
    this->name = name;
    this->birthday = birthday;
    this->gender = gender;
    this->height = height;
    this->address = address;
}

void IDCard::notifyObservers() {
    for (auto* obs : observers_){
        if(obs){
            obs->update(this);
        }
    }
};

QString IDCard::getName() const { return name; }
QString IDCard::getBirthday() const { return birthday; }
QString IDCard::getGender() const { return gender; }
QString IDCard::getHeight() const { return height; }
QString IDCard::getAddress() const { return address; }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


SecureNote::SecureNote(QString noteName, QString noteContent)
{
    this->noteName = noteName;
    this->noteContent = noteContent;
}

void SecureNote::notifyObservers() {
    for (auto* obs : observers_){
        if(obs){
            obs->update(this);
        }
    }
};

QString SecureNote::getNoteName() const { return noteName; }
QString SecureNote::getNoteContent() const { return noteContent; }
