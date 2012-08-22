#include "qmlfilesystemadapter.h"
#include <QDir>
#include <QDebug>

QmlFilesystemAdapter::QmlFilesystemAdapter(QObject *parent) :
    QObject(parent)
{

}

bool QmlFilesystemAdapter::fileExists(QString path)
{
    return QFile(path).exists();
}

bool QmlFilesystemAdapter::copyFile(QString source, QString destination)
{
    return QFile::copy(source, destination);
}

bool QmlFilesystemAdapter::deleteFile(QString path)
{
    return QFile::remove(path);
}

bool QmlFilesystemAdapter::writeToFile(QString path, QString text)
{
    QFile file(path);
    file.open(QFile::WriteOnly | QFile::Truncate | QFile::Text);
    file.write(text.toLocal8Bit());
    bool ret = file.flush();
    file.close();

    return ret;
}

QString QmlFilesystemAdapter::readFromFile(QString path)
{
    QFile file(path);
    file.open(QFile::ReadOnly | QFile::Text);
    QString text = QString::fromLocal8Bit(file.readAll());
    file.close();

    return text;
}
