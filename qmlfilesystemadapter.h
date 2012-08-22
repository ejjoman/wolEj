#ifndef QMLFILESYSTEMADAPTER_H
#define QMLFILESYSTEMADAPTER_H

#include <QObject>
#include <QUrl>
#include <QFileInfo>

class QmlFilesystemAdapter : public QObject
{
        Q_OBJECT
    public:
        explicit QmlFilesystemAdapter(QObject *parent = 0);
        Q_INVOKABLE static bool fileExists(QString path);
        Q_INVOKABLE static bool copyFile(QString source, QString destination);
        Q_INVOKABLE static bool deleteFile(QString path);
        Q_INVOKABLE static bool writeToFile(QString path, QString text);
        Q_INVOKABLE static QString readFromFile(QString path);


    signals:
        
    public slots:
        
};

#endif // QMLFILESYSTEMADAPTER_H
