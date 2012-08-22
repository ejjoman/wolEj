import QtQuick 1.1
import com.nokia.meego 1.1
import com.nokia.extras 1.1
import QtMobility.systeminfo 1.1
import QtMobility.feedback 1.1
import com.ejjoman.plugins 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage
    //showStatusBar: (screen.currentOrientation === Screen.Portrait || screen.currentOrientation === Screen.PortraitInverted)

//    platformStyle: PageStackWindowStyle {
//        property bool cornersVisible: true

//        // Background
//        property string background: Qt.resolvedUrl("../images/background.png")

//        property string landscapeBackground: background
//        property string portraitBackground: background
//        property string portraiteBackground: background

//        property int backgroundFillMode: Image.Tile
//    }

    platformStyle: PageStackWindowStyle {
        id: appStyle

        cornersVisible: true
        background: "image://theme/meegotouch-video-background"
        backgroundFillMode: Image.Stretch
    }

    Page {
        id: splash
        tools: ToolBarLayout {
            visible: true
        }

        PageHeader {
            id: pageHeader

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            title: " "
        }
    }

    MainPage {
        id: mainPage
    }

    DevicePage {
        id: devicePage
    }

    DeviceModel {
        id: devices
    }

    NetworkInfo {
        id: wlanInfo
        mode: NetworkInfo.WlanMode
        monitorStatusChanges: true
    }

    HapticsEffect {
        id: rumbleEffect
        attackIntensity: 1.0
        attackTime: 250
        intensity: 1.0
        duration: 250 // set up the duration here, in millisecond
        fadeTime: 250
        fadeIntensity: 0.0
    }

    HapticsEffect {
        id: contextMenuRumbleEffect
        attackIntensity: 0.0
        attackTime: 100
        intensity: 1.0
        duration: 250 // set up the duration here, in millisecond
        fadeTime: 250
        fadeIntensity: 0.0
    }

    InfoBanner {
        id: infoBanner
        topMargin: 50
    }

    WakeOnLan {
        id: wakeOnLan

        signal sendComplete(string macAddress, string deviceName, bool success)
        property bool showInfoBanner: true
        property bool useHapticsEffect: true

        function send(macAddress, macGroupSeperator, deviceName) {
            if (wlanInfo.networkStatus == "Connected") {
                wakeOnLan.sendMagicPacket(macAddress, macGroupSeperator);

                if (showInfoBanner) {
                    infoBanner.text = "Magisches Paket wurde gesendet"
                    infoBanner.iconSource = "../images/success.png"
                    infoBanner.show()
                }

                if (useHapticsEffect)
                    rumbleEffect.start()

                return true;
            } else {
                if (showInfoBanner) {
                    infoBanner.text = "Fehler: Keine Verbindung mit WLAN"
                    infoBanner.iconSource = "../images/error.png"
                    infoBanner.show()
                }

                return false;
            }
        }
    }

    Filesystem {
        id: fileSystem
    }

    ToolBarLayout {
        id: commonTools
        visible: true

        ToolIcon {
            visible: false // pageStack.depth > 1
            platformIconId: "toolbar-back"
            onClicked: {
                pageStack.pop();
            }
        }
    }

    Component.onCompleted: {
        theme.inverted = true;
    }
}
