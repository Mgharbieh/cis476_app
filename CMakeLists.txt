cmake_minimum_required(VERSION 3.16)

project(cis476_app VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick sql)

qt_standard_project_setup()

qt_add_executable(appcis476_app
    main.cpp
)

qt_add_qml_module(appcis476_app
    URI cis476_app
    VERSION 1.0

    # All QML files
    QML_FILES
        Main.qml
        LoginPage.qml
        WebsiteInfo.qml
        RegisterUser.qml
        SecureNoteInfo.qml
        CreditCard.qml
        IDCard.qml
        RecoverPassPage.qml
        EditWebsiteInfo.qml

    # All C++ headers/sources
    SOURCES
        login.h
        passwordGenerator.h
        Secret.h
        Observer.h
        Account.h
        Secrets.cpp
        databasehandler.h
        databasehandler.cpp
        SecurityQuestionHandler.h
        SecurityQuestionHandler.cpp
        SessionManager.h
        SOURCES notificationObservers.h
        SOURCES notificationObservers.cpp
        SOURCES copyhandler.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appcis476_app PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcis476_app
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appcis476_app
    PRIVATE Qt6::Quick Qt6::Sql
)

include(GNUInstallDirs)
install(TARGETS appcis476_app
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# MSVC requires this for proper __cplusplus value
if (MSVC)
    add_compile_options(/Zc:__cplusplus)
endif()
