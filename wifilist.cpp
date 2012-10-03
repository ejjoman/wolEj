#include "wifilist.h"

WifiList::WifiList(QObject *parent) :
    QObject(parent)
{
    this->manager = new QNetworkConfigurationManager(this);
}

QStringList WifiList::getWifiList()
{
    QStringList wifiList;

    foreach (QNetworkConfiguration config, this->manager->allConfigurations()) {
        if (config.bearerType() == QNetworkConfiguration::BearerWLAN)
            wifiList.append(config.name());
    }

    qSort(wifiList.begin(), wifiList.end(), WifiList::caseInsensitiveLessThan);

    return wifiList;
}


bool WifiList::caseInsensitiveLessThan(const QString &s1, const QString &s2)
{
    return s1.toLower() < s2.toLower();
}
