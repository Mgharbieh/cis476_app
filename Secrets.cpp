#include "Secret.h"
//TODO: Implement all secrets here

Website::Website(QString url, QString username, QString password){
    this->url = url;
    this->username = username;
    this->password.setPass(password);
}

void Website::notifyObservers(){

}

