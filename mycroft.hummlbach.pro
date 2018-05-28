TEMPLATE = app
TARGET = mycroft.hummlbach

load(ubuntu-click)

QT += qml quick

SOURCES += src/main.cpp \
    mycroftcontrol.cpp

RESOURCES += src/qml/qml.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  click/mycroft.hummlbach.apparmor \
               click/mycroft.hummlbach.desktop \
               icon.png

#AP_TEST_FILES += tests/autopilot/run \
#                 $$files(tests/*.py,true)

# show all the files in QtCreator
OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               $${AP_TEST_FILES} \
               click/mycroft.hummlbach.desktop \
               click/manifest.json

HELPER_SCRIPTS += src/ut_mycroft_launcher.sh \
                  src/ut_mycroft_installer.sh

# specify where the scripts are installed to
script_files.path = /scripts
script_files.files += $${HELPER_SCRIPTS}
INSTALLS+=script_files

# specify where the config files are installed to
config_files.path = /
config_files.files += $${CONF_FILES}
INSTALLS+=config_files

# default rules for deployment.
target.path = $${UBUNTU_CLICK_BINARY_PATH}
INSTALLS+=target

# specify the manifest file, this file is required for click
# packaging and for the IDE to create runconfigurations
UBUNTU_MANIFEST_FILE=click/manifest.json

# specify translation domain, this must be equal with the
# app name in the manifest file
UBUNTU_TRANSLATION_DOMAIN="mycroft.hummlbach"

# specify the source files that should be included into
# the translation file, from those files a translation
# mycroft is created in po/mycroft.pot, to create a
# translation copy the mycroft to e.g. de.po and edit the sources
UBUNTU_TRANSLATION_SOURCES+= \
    $$files(*.qml,true) \
    $$files(*.js,true) \
    $$files(*.desktop,true)

# specifies all translations files and makes sure they are
# compiled and installed into the right place in the click package
UBUNTU_PO_FILES+=$$files(po/*.po)

HEADERS += \
    mycroftcontrol.h
