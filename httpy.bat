@echo off
set "SCRIPT_DIR=%~dp0"

python "%SCRIPT_DIR%httpy.py" %*
