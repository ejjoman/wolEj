#include "qmlwakeonlan.h"

QmlWakeOnLan::QmlWakeOnLan(QObject *parent) :
    QObject(parent)
{
    this->udpSocket = new QUdpSocket(this);
}

bool QmlWakeOnLan::sendMagicPacket(QString macAddress)
{
    if (!this->isValidMacAddress(macAddress)) {
        this->error = QObject::tr("Keine gültige MAC-Adresseee: %1").arg(macAddress);
        return false;
    }

    QByteArray macDest = this->cleanMac(macAddress).toLocal8Bit();

    QByteArray magicSequence = QByteArray::fromHex("ffffffffffff");
    for (int i=0; i<16; i++)
        magicSequence.append(QByteArray::fromHex(macDest));

    qint64 byteCount = this->udpSocket->writeDatagram(magicSequence.data(), magicSequence.size(), QHostAddress::Broadcast, 40000);

    if (byteCount == -1)
        this->error = QObject::tr("Magisches Paket konnte nicht gesendet werden");

    return (byteCount > -1);
}

bool QmlWakeOnLan::isValidMacAddress(QString macAddress)
{
    QRegExp r("^([0-9a-f]{2}([:-]|$)){6}$", Qt::CaseInsensitive);
    return r.exactMatch(macAddress);
}

QString QmlWakeOnLan::getError()
{
    return this->error;
}

QString QmlWakeOnLan::cleanMac(QString macAddress)
{
    if (!this->isValidMacAddress(macAddress))
        return QString::null;

    return macAddress.replace(QRegExp("[:-]", Qt::CaseInsensitive), "");
}
