#include "wifimodel.h"

WifiModel::WifiModel(QObject *parent) :
    QAbstractListModel(parent)
{
    this->manager = new QNetworkConfigurationManager(this);
    this->_roleToProperty[NameRole] = "name";

    setRoleNames(this->_roleToProperty);

    foreach(QNetworkConfiguration conf, this->manager->allConfigurations()) {
        if (conf.bearerType() == QNetworkConfiguration::BearerWLAN)
            this->wifiList.append(conf.name());
    }
}

int WifiModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return this->wifiList.size();
}

QVariant WifiModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > this->rowCount()-1)
        return QVariant();

    switch (role) {
        case NameRole:
            return this->wifiList.at(index.row());
            break;
    }

    return QVariant();
}
