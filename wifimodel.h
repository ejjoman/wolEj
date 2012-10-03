#ifndef WIFIMODEL_H
#define WIFIMODEL_H

#include <QAbstractListModel>
#include <QNetworkConfigurationManager>
#include <QStringList>

class WifiModel : public QAbstractListModel
{
    Q_OBJECT
private:
    QNetworkConfigurationManager *manager;
    QHash<int, QByteArray> _roleToProperty;
    QStringList wifiList;

public:
    enum Roles {NameRole = Qt::UserRole + 1};

    explicit WifiModel(QObject *parent = 0);

    // Needed for SelectionDialog
    Q_PROPERTY(int count READ rowCount CONSTANT)

    // QAbstractListModel implementations
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

};

#endif // WIFIMODEL_H
