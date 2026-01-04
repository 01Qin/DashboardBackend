#include <QGuiApplication>
#include <qqml.h>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include "vehicledata1.h"
#include "indicatorcontroller1.h"
#include "vehiclesimulator1.h"

int main(int argc, char *argv[])
{
    // Uncomment env var to scale down app runtime size
    qputenv("QT_SCALE_FACTOR", "0.5");

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Basic");

    qmlRegisterSingletonType<IndicatorController>(
        "Dashord", 1, 0, "IndicatorController",
        [](QQmlEngine *engine, QJSEngine *scriptEngine)-> QObject*{
            Q_UNUSED(scriptEngine)
            return new IndicatorController(engine);
        });

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Dashboard", "Main");

    return app.exec();
}
