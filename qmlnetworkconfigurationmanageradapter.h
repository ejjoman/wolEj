#ifndef QMLNETWORKCONFIGURATIONMANAGERADAPTER_H
#define QMLNETWORKCONFIGURATIONMANAGERADAPTER_H

#include <QObject>
#include <QVariantList>
#include <QNetworkConfigurationManager>

class QmlNetworkConfigurationManagerAdapter : public QObject
{
    Q_OBJECT
private:
    QNetworkConfigurationManager *manager;

public:
    explicit QmlNetworkConfigurationManagerAdapter(QObject *parent = 0);
    Q_INVOKABLE QVariantList getWifis();
    
signals:
    
public slots:
    
};

#endif // QMLNETWORKCONFIGURATIONMANAGERADAPTER_H
