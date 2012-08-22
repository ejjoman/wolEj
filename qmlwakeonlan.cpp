#include "qmlwakeonlan.h"

QmlWakeOnLan::QmlWakeOnLan(QObject *parent) :
    QObject(parent)
{
    this->udpSocket = new QUdpSocket(this);
}

void QmlWakeOnLan::sendMagicPacket(QString macAddress, QChar groupSeparator)
{
    macAddress = macAddress.remove(groupSeparator, Qt::CaseInsensitive);

    QByteArray macDest;

    for (int i=0; i<macAddress.length(); i++)
        macDest.append(macAddress.at(i));

    QByteArray magicSequence = QByteArray::fromHex("ffffffffffff");

    for (int i = 0; i < 16; i++)
        magicSequence.append(QByteArray::fromHex(macDest));

    this->udpSocket->writeDatagram(magicSequence.data(), magicSequence.size(), QHostAddress::Broadcast, 40000);
}
