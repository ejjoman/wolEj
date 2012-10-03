#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qmlclipboardadapter.h"
#include "qmlwakeonlan.h"
#include "qmlfilesystemadapter.h"
#include "qmlsystembanneradapter.h"
#include "wifilist.h"
#include "wifimodel.h"

#include <QSystemNetworkInfo>
#include <meegotouch/MNotification>
#include <QTranslator>
#include <QTextStream>

using namespace QtMobility;

Q_DECL_EXPORT int main(int argc, char *argv[])
{   
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QTextStream qout(stdout);

    QString locale = QLocale::system().name();
    QTranslator translator;

    if (!(translator.load("translation."+locale, ":/")))
        translator.load("translation.en", ":/");

    app->installTranslator(&translator);

    QStringList arguments = app->arguments();

    if (arguments.size() > 1 && arguments.at(1) == "-wake") {
        QString mac = QString::null;

        if (arguments.contains("-mac")) {
            int macIdx = arguments.indexOf("-mac");

            if (macIdx != -1 && arguments.count() >= macIdx+1)
                mac = arguments.at(macIdx+1);
        }

        if (mac == QString::null) {
            qout << QObject::tr("Bitte MAC-Adresse angegeben") << endl;
            return 1;
        } else {
            QString devName = QString::null;

            if (arguments.contains("-devicename")) {
                int nameIdx = arguments.indexOf("-devicename");
                devName = arguments.at(nameIdx+1);
            }

            QSystemNetworkInfo *i = new QSystemNetworkInfo();
            QSystemNetworkInfo::NetworkStatus s = i->networkStatus(QSystemNetworkInfo::WlanMode);

            bool success;

            if (s == QSystemNetworkInfo::Connected) {
                QmlWakeOnLan *w = new QmlWakeOnLan();
                w->sendMagicPacket(mac);

                success = true;
            } else {
                success = false;
            }

            if (arguments.contains("-showbanner")) {
                QString message;

                if (success) {
                    if (devName != QString::null)
                        message = QObject::tr("Magisches Paket wurde an %1 gesendet").arg(devName);
                    else
                        message = QObject::tr("Magisches Paket wurde gesendet");
                } else {
                    message = QObject::tr("Das magische Paket konnte nicht gesendet werden. (Keine Verbindung mit WLAN)");
                }

                MNotification *notification = new MNotification(MNotification::DeviceEvent, QString::null, message);
                notification->setImage((success ? "icon-m-transfer-done" : "icon-m-transfer-error"));
                notification->publish();
            }

            return (success ? 0 : 1);
        }
    }

    qmlRegisterType<QmlClipboardAdapter>("com.ejjoman.plugins", 1, 0, "Clipboard");
    qmlRegisterType<QmlWakeOnLan>("com.ejjoman.plugins", 1, 0, "WakeOnLan");
    qmlRegisterType<QmlFilesystemAdapter>("com.ejjoman.plugins", 1, 0, "Filesystem");

    QmlApplicationViewer viewer;
    QDeclarativeContext *context = viewer.rootContext();

    WifiModel *model = new WifiModel();
    context->setContextProperty("wifiModel", model);

    WifiList list;
    context->setContextProperty("wifiList", QVariant::fromValue(list.getWifiList()));

    QString homePath = QDir::homePath();
    context->setContextProperty("homePath", homePath);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/harmattan/main.qml"));

    viewer.showExpanded();

    qInstallMsgHandler(0);

    return app->exec();
}
