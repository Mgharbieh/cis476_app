#ifndef COPYHANDLER_H
#define COPYHANDLER_H

#include <QObject>
#include <QGuiApplication>
#include <QtQml>
#include <QClipboard>

class CopyHandler : public QObject {
    Q_OBJECT

private:
    QClipboard* clipBoard;

public:
    CopyHandler() { clipBoard = QGuiApplication::clipboard(); }

    Q_INVOKABLE void copyText(QString txt)
    {
        clipBoard->clear();
        clipBoard->setText(txt);
    }
};

#endif // COPYHANDLER_H
