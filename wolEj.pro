# Add more folders to ship with the application, here
folder_01.source = qml/harmattan
folder_01.target = qml

folder_plugins.source = qml/plugins
folder_plugins.target = qml

folder_images.source = qml/images
folder_images.target = qml

folder_resources.source = resources/*
folder_resources.target = resources

DEPLOYMENTFOLDERS = folder_01 folder_plugins folder_images folder_resources

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE568AB0F

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility meegotouch
MOBILITY += feedback systeminfo

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
	qmlclipboardadapter.cpp \
	qmlwakeonlan.cpp \
    qmlfilesystemadapter.cpp \
    qmlsystembanneradapter.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qml/plugins/com/ejjoman/meego/qmldir \
    qml/plugins/com/ejjoman/meego/Separator.qml \
    qml/images/clipboard.png \
	resources/mask.desktop \
    qtc_packaging/debian_harmattan/prerm \
    resources/wolEj.png

HEADERS += \
	qmlclipboardadapter.h \
	qmlwakeonlan.h \
    qmlfilesystemadapter.h \
    qmlsystembanneradapter.h

RESOURCES += \
    resources.qrc

contains(MEEGO_EDITION,harmattan) {
	launcher_icon.files = wolEj80_launcher.png
	launcher_icon.path = /usr/share/icons/hicolor/80x80/apps

	icon.files = wolEj80.png
	icon.path = /usr/share/icons/hicolor/80x80/apps

	INSTALLS += launcher_icon icon
}


#translate_hack{ SOURCES += qml/harmattan/*.qml }