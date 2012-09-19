#include "qmlnetworkconfigurationmanageradapter.h"

QmlNetworkConfigurationManagerAdapter::QmlNetworkConfigurationManagerAdapter(QObject *parent) :
    QObject(parent)
{
    this->manager = new QNetworkConfigurationManager(this);
}

QVariantList QmlNetworkConfigurationManagerAdapter::getWifis()
{
    QVariantList wifiList;

    foreach (QNetworkConfiguration config, this->manager->allConfigurations()) {
        if (config.bearerType() == QNetworkConfiguration::BearerWLAN)
            wifiList.append(config.name());
    }

    return wifiList;
}
