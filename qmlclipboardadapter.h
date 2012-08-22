#ifndef QMLCLIPBOARDADAPTER_H
#define QMLCLIPBOARDADAPTER_H

#include <QObject>
#include <QApplication>
#include <QClipboard>

class QmlClipboardAdapter : public QObject
{
    Q_OBJECT
public:
    explicit QmlClipboardAdapter(QObject *parent = 0);
    Q_INVOKABLE void setText(QString text);
    Q_INVOKABLE QString getText();
    Q_INVOKABLE void clear();

private:
    QClipboard *_clipboard;

signals:

public slots:
};

#endif // QMLCLIPBOARDADAPTER_H
