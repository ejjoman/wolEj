#ifndef QMLWAKEONLAN_H
#define QMLWAKEONLAN_H

#include <QObject>
#include <QUdpSocket>


class QmlWakeOnLan : public QObject
{
        Q_OBJECT
    public:
        explicit QmlWakeOnLan(QObject *parent = 0);
        Q_INVOKABLE void sendMagicPacket(QString MacAddress, QChar GroupSeparator);
        static bool isValidMacAddress(QString MacAddress);

    private:
        QUdpSocket *udpSocket;
};

#endif // QMLWAKEONLAN_H
