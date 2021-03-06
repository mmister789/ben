set -e

yarn build
export QMAKESPEC=macx-clang
export TRAVIS_BUILD_DIR=$PWD

mkdir -p "$TRAVIS_BUILD_DIR-build"
qmake -v
qmake -o "$TRAVIS_BUILD_DIR-build" -r -Wall -Wlogic -Wparser CONFIG+=release PRODUCTION=true "$TRAVIS_BUILD_DIR/native"
make -C "$TRAVIS_BUILD_DIR-build" -j8 all
macdeployqt "$TRAVIS_BUILD_DIR-build/Ben.app" -dmg -qmldir="$TRAVIS_BUILD_DIR/native/dist"