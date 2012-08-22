#include "qmlsystembanneradapter.h"
#include <MNotification>

QmlSystembannerAdapter::QmlSystembannerAdapter(QDeclarativeItem *parent) :
    QObject(parent)
{
}

void QmlSystembannerAdapter::showBanner(QString text, QString icon)
{
    MNotification notification(MNotification::DeviceEvent, "", text);
    notification.setImage(icon);
    notification.publish();
}
