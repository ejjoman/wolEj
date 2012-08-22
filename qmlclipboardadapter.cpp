#include "qmlclipboardadapter.h"

//#include <QClipboard>

QmlClipboardAdapter::QmlClipboardAdapter(QObject *parent) :
    QObject(parent)
{
    this->_clipboard = QApplication::clipboard();
}

void QmlClipboardAdapter::setText(QString text)
{
    this->_clipboard->setText(text, QClipboard::Clipboard);
    //this->_clipboard->setText(text, QClipboard::Selection);
}

QString QmlClipboardAdapter::getText()
{
    return this->_clipboard->text(QClipboard::Clipboard);
}

void QmlClipboardAdapter::clear()
{
    this->_clipboard->clear(QClipboard::Clipboard);
}
