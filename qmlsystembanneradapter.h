#ifndef QMLSYSTEMBANNERADAPTER_H
#define QMLSYSTEMBANNERADAPTER_H

#include <QDeclarativeItem>

class QmlSystembannerAdapter : public QObject
{
    Q_OBJECT
public:
    explicit QmlSystembannerAdapter(QDeclarativeItem *parent = 0);
    Q_INVOKABLE void showBanner(QString text, QString icon);

signals:
    
public slots:
    
};

#endif // QMLSYSTEMBANNERADAPTER_H
