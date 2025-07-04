@echo off
echo ========================================
echo    TESTANDO E ENCONTRANDO ADB
echo ========================================

echo.
echo Procurando ADB...

REM Tentar encontrar ADB em locais comuns
set ADB_PATH=

REM Verificar se está no PATH
where adb >nul 2>&1
if %errorlevel% == 0 (
    set ADB_PATH=adb
    echo ✅ ADB encontrado no PATH
    goto :test_adb
)

REM Verificar Android Studio (local mais comum)
if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
    echo ✅ ADB encontrado em Android Studio
    goto :test_adb
)

REM Verificar outros locais possíveis
if exist "C:\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH="C:\Android\Sdk\platform-tools\adb.exe"
    echo ✅ ADB encontrado em C:\Android\Sdk
    goto :test_adb
)

REM Verificar Program Files
if exist "C:\Program Files\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH="C:\Program Files\Android\Sdk\platform-tools\adb.exe"
    echo ✅ ADB encontrado em Program Files
    goto :test_adb
)

echo.
echo ❌ ADB não encontrado!
echo.
echo Soluções:
echo 1. Instale o Android Studio
echo 2. Adicione o ADB ao PATH do sistema
echo 3. Verifique se o Android SDK está instalado
echo.
echo Locais verificados:
echo - %LOCALAPPDATA%\Android\Sdk\platform-tools\
echo - C:\Android\Sdk\platform-tools\
echo - C:\Program Files\Android\Sdk\platform-tools\
echo.
pause
exit /b 1

:test_adb
echo.
echo Testando ADB...
%ADB_PATH% version

echo.
echo Verificando dispositivos...
%ADB_PATH% devices

echo.
echo ========================================
echo    ADB FUNCIONANDO!
echo ========================================
echo.
echo Use o caminho: %ADB_PATH%
echo.
pause 