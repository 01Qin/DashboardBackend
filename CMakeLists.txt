cmake_minimum_required(VERSION 3.16)

project(dashboard-backend VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appdashboard
    main.cpp

)

qt_add_qml_module(appdashboard
    URI Dashboard
    VERSION 1.0
    QML_FILES
        IndicatorPane.qml
        Main.qml
        RpmGauge.qml
        SpeedGauge.qml
        FuelDisplay.qml
        SpeedDisplay.qml
        SpeedWarning.qml
        TripDisplay.qml
    RESOURCES
        images/fuel_off.png
        images/fuel_on.png
        images/needleorange.png
        images/needlered.png
        images/parkingbrake_off.png
        images/parkingbrake_on.png
        images/rpmgauge.png
        images/speedgauge.png
        images/turnleft_off.png
        images/turnleft_on.png
        images/turnright_off.png
        images/turnright_on.png
    SOURCES

        vehicledata1.cpp
        vehicledata1.h
        indicatorcontroller1.cpp
        indicatorcontroller1.h
        vehiclesimulator1.cpp
        vehiclesimulator1.h
        tripcomputer.h
        tripcomputer.cpp



)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdashboard PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdashboard
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdashboard
    PRIVATE Qt6::Quick Qt6::QuickControls2
)
target_link_libraries(appdashboard PRIVATE Qt6::Core)

include(GNUInstallDirs)
install(TARGETS appdashboard
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
