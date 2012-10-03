#ifndef WIFILIST_H
#define WIFILIST_H

#include <QObject>
#include <QStringList>
#include <QNetworkConfigurationManager>

class WifiList : public QObject
{
    Q_OBJECT
private:
    QNetworkConfigurationManager *manager;
    static bool caseInsensitiveLessThan(const QString &s1, const QString &s2);

public:
    explicit WifiList(QObject *parent = 0);
    QStringList getWifiList();

signals:
    
public slots:
    
};

#endif // WIFILIST_H
