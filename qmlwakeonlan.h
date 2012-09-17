#ifndef QMLWAKEONLAN_H
#define QMLWAKEONLAN_H

#include <QObject>
#include <QUdpSocket>
#include <QRegExp>
#include <QRegExpValidator>

class QmlWakeOnLan : public QObject
{
    Q_OBJECT
    public:
        explicit QmlWakeOnLan(QObject *parent = 0);
        Q_INVOKABLE bool sendMagicPacket(QString macAddress);
        Q_INVOKABLE bool isValidMacAddress(QString macAddress);
        Q_INVOKABLE QString getError();

    private:
        QString error;
        QUdpSocket *udpSocket;
        QString cleanMac(QString macAddress);
};

#endif // QMLWAKEONLAN_H
