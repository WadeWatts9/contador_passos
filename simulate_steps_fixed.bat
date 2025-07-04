@echo off
echo ========================================
echo    SIMULADOR DE PASSOS - WEAR OS
echo ========================================

echo.
echo Procurando ADB...

REM Tentar encontrar ADB em locais comuns
set ADB_PATH=

REM Verificar se está no PATH
where adb >nul 2>&1
if %errorlevel% == 0 (
    set ADB_PATH=adb
    echo ADB encontrado no PATH
    goto :found_adb
)

REM Verificar Android Studio
if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH="%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe"
    echo ADB encontrado em Android Studio
    goto :found_adb
)

REM Verificar outros locais possíveis
if exist "C:\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH="C:\Android\Sdk\platform-tools\adb.exe"
    echo ADB encontrado em C:\Android\Sdk
    goto :found_adb
)

echo.
echo ERRO: ADB não encontrado!
echo.
echo Soluções:
echo 1. Instale o Android Studio
echo 2. Adicione o ADB ao PATH do sistema
echo 3. Execute manualmente os comandos:
echo.
echo %LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe devices
echo.
pause
exit /b 1

:found_adb
echo.
echo 1. Verificando dispositivos conectados...
%ADB_PATH% devices

echo.
echo 2. Digite o nome do dispositivo/emulador (apenas o nome, sem 'device'):
set /p device_name=

echo.
echo 3. Ativando provedores sintéticos...
%ADB_PATH% -s %device_name% shell am broadcast -a "whs.USE_SYNTHETIC_PROVIDERS" com.google.android.wearable.healthservices

echo.
echo 4. Iniciando simulação de caminhada...
%ADB_PATH% -s %device_name% shell am broadcast -a "whs.synthetic.user.START_WALKING" com.google.android.wearable.healthservices

echo.
echo 5. Aguardando 10 segundos para gerar dados...
timeout /t 10 /nobreak

echo.
echo 6. Parando simulação...
%ADB_PATH% -s %device_name% shell am broadcast -a "whs.synthetic.user.STOP_EXERCISE" com.google.android.wearable.healthservices

echo.
echo ========================================
echo    SIMULAÇÃO CONCLUÍDA!
echo ========================================
echo.
echo Agora você pode abrir o app no smartphone
echo para ver os dados de passos sincronizados.
echo.
pause 