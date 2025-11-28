#include "Secret.h"
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

QString Website::getURL() { return url; }
QString Website::getUserName() { return username; }
QString Website::getPassword() {return password.getPassword(); }
