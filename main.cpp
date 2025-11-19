#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "UserManager.h"
#include "BookingManager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    UserManager userManager;
    BookingManager bookingManager(&userManager);

    engine.rootContext()->setContextProperty("userManager", &userManager);
    engine.rootContext()->setContextProperty("bookingManager", &bookingManager);

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
