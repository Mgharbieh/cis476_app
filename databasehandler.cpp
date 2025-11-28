#include "databasehandler.h"

DatabaseHandler::DatabaseHandler(): _weakObserver(this), _expirationObserver(this)
{}

void DatabaseHandler::loadSavedData()
{
    QSqlQuery query;

    //Find a row where both the username and password matching
    query.prepare("SELECT * FROM vault_db "
                  "WHERE id = ? AND user_id = ?");
    query.bindValue(0, user_ID);
    query.bindValue(1, user_name);
    query.exec();

    while(query.next())
    {
        QString type = query.value("type").toString();

        if(type == "website")
        {
            QString url = query.value("url").toString();
            QString user = query.value("username").toString();
            QString pass = query.value("password").toString();

            Website* website = new Website(url, user, pass);
            vault.push_back(website);
            int idx = static_cast<int>(vault.size() - 1);

            website->registerObserver(&_weakObserver);

            website->notifyObservers();
            emit itemLoaded("website", url, idx);
        }
        else if(type == "credit card")
        {

        }
        else if(type == "ID card")
        {

        }
        else if(type == "secure note")
        {

        }
    }
}

void DatabaseHandler::userLogin(QString id, QString name)
{
    user_ID = id;
    user_name = name;
    loadSavedData();
}

void DatabaseHandler::initDatabase()
{
    if(isConnected == false)
    {
        qDebug() << "Available SQL drivers:" << QSqlDatabase::drivers();
        // Use the PostgreSQL driver

        db = QSqlDatabase::addDatabase("QODBC");

        // Build an ODBC connection string.
        QString connStr =
            "Driver={PostgreSQL ODBC Driver(UNICODE)};"
            "Server=shinkansen.proxy.rlwy.net;"
            "Port=17700;"
            "Database=railway;"
            "Uid=postgres;"
            "Pwd=AXKYvzjVxofQHczfQgVsxcSGWSjWtiZF;"
            "SSLmode=require;";

        db.setDatabaseName(connStr);

        if (!db.open()) {
            qWarning() << "ODBC connection failed:" << db.lastError().text();
        } else {
            qInfo() << "Connected to PostgreSQL on Railway via ODBC!";
            isConnected = true;
        }
    }
}

void DatabaseHandler::closeDatabase()
{
    if(isConnected == true)
    {
        db.close();
        isConnected = false;
    }
}

void DatabaseHandler::registerAccount(QString user, QString pass, QString q1, QString a1, QString q2, QString a2, QString q3, QString a3)
{
    QUuid uuid;
    QString idStr = uuid.createUuid().toString(QUuid::WithoutBraces);

    QSqlQuery query;
    query.prepare("INSERT INTO accounts (id, username, password, question1, answer1, question2, answer2, question3, answer3) "
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    query.bindValue(0, idStr);
    query.bindValue(1, user);
    query.bindValue(2, pass);
    query.bindValue(3, q1);
    query.bindValue(4, a1);
    query.bindValue(5, q2);
    query.bindValue(6, a2);
    query.bindValue(7, q3);
    query.bindValue(8, a3);
    query.exec();
}

void DatabaseHandler::saveWebsite(QString url, QString user, QString pass)
{
    QSqlQuery query;
    query.prepare("INSERT INTO vault_db (id, user_id, type, username, password, url) "
                  "VALUES (?, ?, ?, ?, ?, ?)");
    query.bindValue(0, user_ID);
    query.bindValue(1, user_name);
    query.bindValue(2, "website");
    query.bindValue(3, user);
    query.bindValue(4, pass);
    query.bindValue(5, url);
    query.exec();

    // Create that in memory secret shhhhh :)
    Website* website = new Website(url, user, pass);

    vault.push_back(website);
    int idx = static_cast<int>(vault.size() - 1);

    // Register the weak password observer for Website
    website->registerObserver(&_weakObserver);

    // Check immediately
    website->notifyObservers();

    // Notify QML that a new item exists
    emit itemLoaded("website", url, idx);
}

void DatabaseHandler::saveCC(QString name, QString ccNum, QString ccv, QString expiryDate, QString zipCode)
{
    QSqlQuery query;
    query.prepare("INSERT INTO vault_db (id, user_id, type, name, credit_num, credit_cvv, expiration, zip_code) "
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    query.bindValue(0, user_ID);
    query.bindValue(1, user_name);
    query.bindValue(2, "credit card");
    query.bindValue(3, name);
    query.bindValue(4, ccNum);
    query.bindValue(5, ccv);
    query.bindValue(6, expiryDate);
    query.bindValue(7, zipCode);
    query.exec();
}

void DatabaseHandler::saveIDCard(QString name, QString bday, QString gender, QString height, QString address)
{
    QSqlQuery query;
    query.prepare("INSERT INTO vault_db (id, user_id, type, name, birthday, gender, height, address) "
                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    query.bindValue(0, user_ID);
    query.bindValue(1, user_name);
    query.bindValue(2, "ID card");
    query.bindValue(3, name);
    query.bindValue(4, bday);
    query.bindValue(5, gender);
    query.bindValue(6, height);
    query.bindValue(7, address);
    query.exec();
}

void DatabaseHandler::saveNote(QString name, QString text)
{
    QSqlQuery query;
    query.prepare("INSERT INTO vault_db (id, user_id, type, title, note) "
                  "VALUES (?, ?, ?, ?, ?)");
    query.bindValue(0, user_ID);
    query.bindValue(1, user_name);
    query.bindValue(2, "secure note");
    query.bindValue(3, name);
    query.bindValue(4, text);
    query.exec();
}

void DatabaseHandler::loadWebsite(int index)
{
    if (index < 0 || index >= static_cast<int>(vault.size()))
        return;

    Website* website = dynamic_cast<Website*>(vault[index]);
    if (!website)
        return;

    qDebug() << "Loading website at index" << index
              << website->getURL()
              << website->getUserName()
              << website->getPassword();

    emit websiteLoaded(website->getURL(),
                       website->getUserName(),
                       website->getPassword());
}

void DatabaseHandler::reportWeakPassword(ISecret* secret)
{
    auto it = std::find(vault.begin(), vault.end(), secret);
    if (it == vault.end())
        return;

    int idx = static_cast<int>(std::distance(vault.begin(), it));
    emit weakPasswordFlagged(idx);
}

void DatabaseHandler::reportExpiryIssue(ISecret* secret)
{
    auto it = std::find(vault.begin(), vault.end(), secret);
    if (it == vault.end())
        return;

    int idx = static_cast<int>(std::distance(vault.begin(), it));
    emit expiryIssueFlagged(idx);
}
