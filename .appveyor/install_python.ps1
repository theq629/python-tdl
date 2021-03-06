if ($env:PYPY -or $env:PYPY3) {
    if($env:PYPY3){
        $env:PYPY_EXE='pypy3.exe'
        $env:PYPY=$env:PYPY3
    } else {
        $env:PYPY_EXE='pypy.exe'
    }
    $env:PYTHON = 'C:\' + $env:PYPY + '\' + $env:PYPY_EXE
    $env:PATH += ';' + 'C:\' + $env:PYPY + '\'
    $PYPY_DOWNLOAD = 'https://bitbucket.org/pypy/pypy/downloads/' + $env:PYPY + '.zip'
    Invoke-WebRequest $PYPY_DOWNLOAD -OutFile C:\pypy.zip
    & '7z' x C:\pypy.zip -oC:\
    & $env:PYTHON -m ensurepip
}
& $env:PYTHON -m pip install --disable-pip-version-check virtualenv
& $env:PYTHON -m virtualenv venv

if ($env:PYPY) {
    $env:ACTIVATE_VENV='venv\bin\activate.bat'
} else {
    $env:ACTIVATE_VENV='venv\Scripts\activate.bat'
}

if($LastExitCode -ne 0) { $host.SetShouldExit($LastExitCode )  }
