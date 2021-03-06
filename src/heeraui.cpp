#include "heeraui.h"
#include "thememanager.h"
#include "iconthemeprovider.h"
#include "shadowhelper/windowshadow.h"

#include <QDebug>
#include <QQmlEngine>
#include <QQuickStyle>

void HeeraUI::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("HeeraUI"));

    // Set base URL to the plugin URL
    engine->setBaseUrl(baseUrl());

    // For system icons
    engine->addImageProvider(QStringLiteral("icontheme"), new IconThemeProvider());
}

void HeeraUI::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("HeeraUI"));

    qmlRegisterSingletonType<ThemeManager>("HeeraUI.Core", 1, 0, "ThemeManager", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return new ThemeManager;
    });

    qmlRegisterType<WindowShadow>(uri, 1, 0, "WindowShadow");

    qmlRegisterSingletonType(componentUrl(QStringLiteral("Theme.qml")), uri, 1, 0, "Theme");
    qmlRegisterSingletonType(componentUrl(QStringLiteral("Units.qml")), uri, 1, 0, "Units");

    qmlRegisterType(componentUrl(QStringLiteral("BusyIndicator.qml")), uri, 1, 0, "BusyIndicator");
    qmlRegisterType(componentUrl(QStringLiteral("Icon.qml")), uri, 1, 0, "Icon");
    qmlRegisterType(componentUrl(QStringLiteral("PopupTips.qml")), uri, 1, 0, "PopupTips");
    qmlRegisterType(componentUrl(QStringLiteral("RoundedRect.qml")), uri, 1, 0, "RoundedRect");
    qmlRegisterType(componentUrl(QStringLiteral("Toast.qml")), uri, 1, 0, "Toast");
    qmlRegisterType(componentUrl(QStringLiteral("Window.qml")), uri, 1, 0, "Window");
    qmlRegisterType(componentUrl(QStringLiteral("WindowButton.qml")), uri, 1, 0, "WindowButton");

    qmlProtectModule(uri, 1);
}

QUrl HeeraUI::componentUrl(const QString &fileName) const
{
    return QUrl(QStringLiteral("qrc:/heera/kit/") + fileName);
}
