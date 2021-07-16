set(TARGET HeeraUI)
set(MODULE_VERSION "1.0")

set(SOURCES
    heeraui.cpp
    iconthemeprovider.cpp
    thememanager.cpp
    shadowhelper/windowshadow.cpp
    shadowhelper/boxshadowrenderer.cpp
    shadowhelper/tileset.cpp

    heeraui.qrc
    heeraui-style/style.qrc
)

add_library(${TARGET} SHARED ${SOURCES})

target_link_libraries (${TARGET}
    PUBLIC
        Qt5::Core
        Qt5::Gui
        Qt5::DBus
    PRIVATE
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
        KF5::WindowSystem
)
include(GenerateExportHeader)
generate_export_header(${TARGET} BASE_NAME ${TARGET})
install(TARGETS ${TARGET} EXPORT ${TARGET}Targets ${INSTALL_TARGETS_DEFAULT_ARGS})

install(TARGETS ${TARGET} DESTINATION ${INSTALL_QMLDIR}/${TARGET})

# Install Controls
install(DIRECTORY controls/ DESTINATION ${INSTALL_QMLDIR}/${TARGET})

# INSTALL STYLE
install(DIRECTORY heeraui-style DESTINATION ${INSTALL_QMLDIR}/QtQuick/Controls.2)
