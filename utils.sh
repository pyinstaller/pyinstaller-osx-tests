#!/usr/bin/env bash
# Use with ``source utils.sh``

function install_dependencies {
    if [ $DEPENDENCIES = macports ]; then
        sudo port -qp install py$PYTHON_VERSION-crypto
        sudo port -qp install py$PYTHON_VERSION-boto
        sudo port -qp install py$PYTHON_VERSION-boto3
        sudo port -qp install py$PYTHON_VERSION-pygments
        sudo port -qp install py$PYTHON_VERSION-pylint
        sudo port -qp install py$PYTHON_VERSION-markdown
        sudo port -qp install py$PYTHON_VERSION-simplejson
        sudo port -qp install py$PYTHON_VERSION-sphinx
        sudo port -qp install py$PYTHON_VERSION-sphinx_rtd_theme
        sudo port -qp install py$PYTHON_VERSION-zmq
        sudo port -qp install py$PYTHON_VERSION-zopeinterface
        sudo port -qp install py$PYTHON_VERSION-numpy
        sudo port -qp install py$PYTHON_VERSION-lxml
        sudo port -qp install py$PYTHON_VERSION-pycparser
        sudo port -qp install py$PYTHON_VERSION-tz
        sudo port -qp install py$PYTHON_VERSION-sqlalchemy
        sudo port -qp install py$PYTHON_VERSION-Pillow
        sudo port -qp install py$PYTHON_VERSION-dateutil
        sudo port -qp install py$PYTHON_VERSION-pandas
        sudo port -qp install py$PYTHON_VERSION-matplotlib
        # No binary archives for pyqt*, due to license conflict, which causes build too run to long
        #sudo port -qp install py$PYTHON_VERSION-pyqt4
        #sudo port -qp install py$PYTHON_VERSION-pyqt5
        #sudo port -qp install py$PYTHON_VERSION-pyside Runs too long
        sudo port -qp install py$PYTHON_VERSION-tkinter
        sudo port -qp install py$PYTHON_VERSION-enchant
        sudo port -qp install py$PYTHON_VERSION-gevent
        sudo port -qp install gstreamer1
        sudo port -qp install py$PYTHON_VERSION-gobject3
    fi
    if [ $DEPENDENCIES = homebrew ]; then
        if [ $PYTHON_VERSION = 2 ]; then
            brew tap homebrew/python
            brew install python-markdown
            brew install numpy
            brew install Pillow
            brew install matplotlib
            brew install wxpython
            brew install enchant --with-python
            brew install pyqt
            travis_wait brew install pyqt5 --with-python --without-python3
            #travis_wait brew install pyside Takes to long
            brew install gst-python
        fi
        if [ $PYTHON_VERSION = 3 ]; then
            brew tap homebrew/python
            brew install numpy --with-python3 --without-python
            brew install Pillow --with-python3 --without-python
            brew install matplotlib --with-python3 --without-python
            travis_wait brew install pyqt --with-python3 --without-python
            brew install pyqt5
            #travis_wait brew install pyside --with-python3 --without-python Takes to long
            brew install pygobject3 --with-python3 --without-python
        fi
        install_virtualenv
        make_workon_venv $TRAVIS_BUILD_DIR
    fi
    toggle_py_sys_site_packages
    #${PIP_CMD} install -r $TRAVIS_BUILD_DIR/$REPO_DIR/tests/requirements-mac.txt | cat
    export ACCEL_CMD=`dirname $PIP_CMD`/pip-accel
    ${ACCEL_CMD} install -r $TRAVIS_BUILD_DIR/$REPO_DIR/tests/requirements-mac.txt | cat
}
