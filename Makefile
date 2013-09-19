#
#
#

XCTOOL:=xctool
PROJECT:=TPSegmentedControl.xcodeproj
SCHEME:=TPSegmentedControl
SDK:=iphonesimulator
CONFIGURATION:=Debug
SETTINGS:=ONLY_ACTIVE_ARCH=NO VALID_ARCHS=i386
TESTSDK:=iphonesimulator7.0

BASEOPTS=\
 -project ${PROJECT} \
 -scheme ${SCHEME} \
 -sdk ${SDK} \
 -configuration ${CONFIGURATION} \
 ${SETTINGS}

all:
	@echo "usage: ${MAKE} {clean|build|test}"

clean build:
	${XCTOOL} ${BASEOPTS} $@

test:
	@echo "No test for this class"
#	${XCTOOL} ${BASEOPTS} -arch i386 $@ -test-sdk ${TESTSDK}

check: test

# EOF
