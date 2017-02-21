TEMPLATE = app
TARGET = liri-browser

CONFIG += c++11
QT += qml quick quickcontrols2 widgets

# Install to /usr/local by default
# Set the PREFIX environment variable to define
# a custom installation location
prefix = $$(PREFIX)
isEmpty(prefix) {
    prefix = /usr/local
}
target.path = $${prefix}/bin
INSTALLS += target

# Load QuaZIP library
linux:LIBS += -L/usr/local/lib -lquazip

# Show useful files in QtCreator
OTHER_FILES += README.md \
               LICENSE*

# Specify CONFIG+=QTWEBENGINE_ENABLED when running qmake.
# Otherwise, Liri Browser expects the Oxide web engine.
contains(CONFIG, QTWEBENGINE_ENABLED) {
    message("Found QTWEBENGINE_ENABLED in CONFIG")
    QT += webengine
    DEFINES += IS_QTWEBENGINE_ENABLED
    message("Using QtWebEngine")
}

# Enable High DPI scaling if Qt >= 5.6
greaterThan(QT_MAJOR_VERSION, 4) {
    greaterThan(QT_MINOR_VERSION, 5) {
        DEFINES += ENABLE_HIGH_DPI_SCALING
        message("Using high-dpi scaling")
    }
}

# Include sub project include files
include(src/3rdparty/3rdparty.pri)
include(src/core/core.pri)
include(src/main/main.pri)
include(src/ui/ui.pri)
include(src/extensions/extensions.pri)
