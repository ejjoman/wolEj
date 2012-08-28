// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.1

Item {
    id: root
    width: 400; height: 400

    signal clicked();
    signal pressAndHold();

    MouseArea {
        id: ma
        anchors.fill: parent

        onClicked: {
            ma.enabled = false;
            playbanner.start()
            root.clicked();
        }

        onPressAndHold: root.pressAndHold();
    }

    Image {
        id: buttonOff
        source: "images/ButtonOff.png"
        smooth: true

        anchors.fill: parent
        z:1
    }

    Image {
        id: buttonPressed
        source: "images/ButtonOffPressed.png"
        smooth: true

        anchors.fill: parent

        opacity: (ma.pressed ? 1 : 0)

        Behavior on opacity {
            PropertyAnimation { duration: 50 }
        }
        z:2
    }

    Image {
        id: buttonOn
        source: "images/ButtonOn.png"
        smooth: true

        anchors.fill: parent

        opacity: 0

        z:3
    }

    SequentialAnimation {
        id: playbanner
        running: false
        NumberAnimation {
            target: buttonOn
            property: "opacity"
            to: 1.0
            duration: 200

            easing.type: Easing.OutExpo
        }

        PauseAnimation { duration: 500 }

        NumberAnimation {
            target: buttonOn
            property: "opacity"
            to: 0.0
            duration: 200

            easing.type: Easing.InExpo
        }

        onCompleted: {
            ma.enabled = true;
        }
    }
}
