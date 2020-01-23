import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.12
import "../Components"
import "../Constants"

// Open Enable Coin Modal
Popup {
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    // Inside modal
    ColumnLayout {
        id: modal_layout

        DefaultText {
            text: qsTr("Enable coins")
            font.pointSize: Style.textSize2
        }

        // List
        ListView {
            implicitWidth: contentItem.childrenRect.width
            implicitHeight: contentItem.childrenRect.height

            model: API.get().enableable_coins
            clip: true

            delegate: Rectangle {
                property bool hovered: false
                property bool selected: false

                color: selected ? Style.colorTheme2 : hovered ? Style.colorTheme4 : "transparent"

                width: 250
                height: 50

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged: hovered = containsMouse
                    //onClicked: API.get().current_coin_info.ticker = model.modelData.ticker
                }

                // Icon
                Image {
                    id: icon
                    anchors.left: parent.left
                    anchors.leftMargin: 20

                    source: General.image_path + "coins/" + model.modelData.ticker.toLowerCase() + ".png"
                    fillMode: Image.PreserveAspectFit
                    width: Style.textSize2
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Name
                DefaultText {
                    anchors.left: icon.right
                    anchors.leftMargin: Style.iconTextMargin

                    text: model.modelData.name + " (" + model.modelData.ticker + ")"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Buttons
        RowLayout {
            Button {
                text: qsTr("Close")
                Layout.fillWidth: true
                onClicked: enable_coin_modal.close()
            }
            Button {
                text: qsTr("Enable")
                Layout.fillWidth: true
                onClicked: console.log(JSON.stringify(API.get().enableable_coins))
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:600;width:1200}
}
##^##*/