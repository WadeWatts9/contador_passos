@echo off
echo ========================================
echo    SIMULADOR DE PASSOS - WEAR OS
echo ========================================

echo.
echo 1. Verificando dispositivos conectados...
adb devices

echo.
echo 2. Digite o nome do dispositivo/emulador:
set /p device_name=

echo.
echo 3. Ativando provedores sintéticos...
adb -s %device_name% shell am broadcast -a "whs.USE_SYNTHETIC_PROVIDERS" com.google.android.wearable.healthservices

echo.
echo 4. Iniciando simulação de caminhada...
adb -s %device_name% shell am broadcast -a "whs.synthetic.user.START_WALKING" com.google.android.wearable.healthservices

echo.
echo 5. Aguardando 10 segundos para gerar dados...
timeout /t 10 /nobreak

echo.
echo 6. Parando simulação...
adb -s %device_name% shell am broadcast -a "whs.synthetic.user.STOP_EXERCISE" com.google.android.wearable.healthservices

echo.
echo ========================================
echo    SIMULAÇÃO CONCLUÍDA!
echo ========================================
echo.
echo Agora você pode abrir o app no smartphone
echo para ver os dados de passos sincronizados.
echo.
pause 