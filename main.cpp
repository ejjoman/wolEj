#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qmlclipboardadapter.h"
#include "qmlwakeonlan.h"
#include "qmlfilesystemadapter.h"
#include "qmlsystembanneradapter.h"

#include <QSystemNetworkInfo>
#include <meegotouch/MNotification>
#include <QTranslator>

using namespace QtMobility;

Q_DECL_EXPORT int main(int argc, char *argv[])
{   
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QStringList arguments = app->arguments();

    if (arguments.size() > 1 && arguments.at(1) == "-wake") {
        QString mac = QString::null;

        if (arguments.contains("-mac")) {
            int macIdx = arguments.indexOf("-mac");

            if (macIdx != -1 && arguments.count() >= macIdx+1)
                mac = arguments.at(macIdx+1);
        } else {
            qDebug() << "Bitte MAC-Adresse angegeben" << endl;
            return 1;
        }

        QString devName = QString::null;
        if (mac != QString::null) {
            int nameIdx = -1;

            if (arguments.contains("-devicename"))
                nameIdx = arguments.indexOf("-devicename");

            if (nameIdx != -1 && arguments.count() >= nameIdx+1)
                devName = arguments.at(nameIdx+1);
        }

        if (mac != QString::null) {
            QSystemNetworkInfo *i = new QSystemNetworkInfo();
            QSystemNetworkInfo::NetworkStatus s = i->networkStatus(QSystemNetworkInfo::WlanMode);

            QString message;
            QString image;

            int retCode = 0;

            if (s == QSystemNetworkInfo::Connected) {
                QmlWakeOnLan *w = new QmlWakeOnLan();
                w->sendMagicPacket(mac, ':');

                image = "icon-m-transfer-done";

                if (devName != QString::null)
                    message = QObject::tr("Magisches Paket wurde an %1 gesendet").arg(devName);
                else
                    message = QObject::tr("Magisches Paket wurde gesendet");
            } else {
                image = "icon-m-transfer-error";
                message = QObject::tr("Das magische Paket konnte nicht gesendet werden. (Keine Verbindung mit WLAN)");
                retCode = 1;
            }

            if (arguments.contains("-showbanner")) {
                MNotification notification(MNotification::DeviceEvent, "", message);
                notification.setImage(image);
                notification.publish();
            }

            return retCode;
        }
    }

    qmlRegisterType<QmlClipboardAdapter>("com.ejjoman.plugins", 1, 0, "Clipboard");
    qmlRegisterType<QmlWakeOnLan>("com.ejjoman.plugins", 1, 0, "WakeOnLan");
    qmlRegisterType<QmlFilesystemAdapter>("com.ejjoman.plugins", 1, 0, "Filesystem");
    qmlRegisterType<QmlSystembannerAdapter>("com.ejjoman.plugins", 1, 0, "Systembanner");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/harmattan/main.qml"));
    viewer.showExpanded();

    qInstallMsgHandler(0);

    return app->exec();
}
