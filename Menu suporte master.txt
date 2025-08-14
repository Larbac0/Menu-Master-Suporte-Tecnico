@echo off
:: ==============================================
:: MENU MASTER DE SUPORTE TECNICO - SoftWave Solutions V1.0
:: Créditos: Igor Cabral
:: ==============================================
:: Rodar como administrador
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo.
    echo Este script precisa ser executado como Administrador!
    pause
    exit
)

color 0A
title MENU MASTER DE SUPORTE TECNICO - SoftWave Solutions V1.0

:menu
cls
echo ==================================================
echo             MENU MASTER SUPORTE TECNICO
echo ==================================================
echo 0 - Sair
echo 1 - Rede
echo 2 - Impressoras
echo 3 - Sistema
echo 4 - Instalar Aplicativos e Drivers
echo ==================================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto sair
if "%opcao%"=="1" goto rede
if "%opcao%"=="2" goto impressoras
if "%opcao%"=="3" goto sistema
if "%opcao%"=="4" goto instaladores

echo Opcao invalida.
pause
goto menu

:: ==============================================
:: MENU REDE
:rede
cls
echo ================== REDE ==================
echo 0 - Voltar
echo 1 - Informacoes completas da rede (ipconfig /all)
echo 2 - Flush DNS
echo 3 - Ping Servidor/IP
echo 4 - Reset Winsock + IP
echo 5 - Rotas de rede
echo 6 - Conexoes ativas (netstat)
echo 7 - Renovar IP
echo 8 - Testar DNS Google
echo 9 - Ver IP Publico
echo 10 - Limpar cache DNS + renovar IP + resetar rede
echo ===========================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" ipconfig /all & pause & goto rede
if "%opcao%"=="2" ipconfig /flushdns & pause & goto rede
if "%opcao%"=="3" set /p ipNome=Digite IP/Host: & ping %ipNome% & pause & goto rede
if "%opcao%"=="4" netsh winsock reset & netsh int ip reset & pause & goto rede
if "%opcao%"=="5" route print & pause & goto rede
if "%opcao%"=="6" netstat -ano & pause & goto rede
if "%opcao%"=="7" ipconfig /release & ipconfig /renew & pause & goto rede
if "%opcao%"=="8" nslookup www.google.com & pause & goto rede
if "%opcao%"=="9" powershell -Command "(Invoke-WebRequest -uri 'https://ifconfig.me/ip').Content" & pause & goto rede
if "%opcao%"=="10" netsh winsock reset & netsh int ip reset & ipconfig /release & ipconfig /renew & ipconfig /flushdns & pause & goto rede

goto rede

:: ==============================================
:: MENU IMPRESSORAS
:impressoras
cls
echo =============== IMPRESSORAS ===============
echo 0 - Voltar
echo 1 - Corrigir erro 0x0000011b
echo 2 - Corrigir erro 0x00000bcb
echo 3 - Corrigir erro 0x00000709
echo 4 - Reiniciar spooler de impressao
echo 5 - Listar impressoras instaladas
echo 6 - Limpar fila de impressao
echo ===========================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f & echo Corrigido! & pause & goto impressoras
if "%opcao%"=="2" reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f & echo Corrigido! & pause & goto impressoras
if "%opcao%"=="3" reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f & echo Corrigido! & pause & goto impressoras
if "%opcao%"=="4" net stop spooler & timeout /t 2 >nul & net start spooler & echo Spooler reiniciado! & pause & goto impressoras
if "%opcao%"=="5" wmic printer get name, default & pause & goto impressoras
if "%opcao%"=="6" net stop spooler & del /Q /F /S "%systemroot%\System32\spool\PRINTERS\*" & net start spooler & echo Fila limpa! & pause & goto impressoras

goto impressoras

:: ==============================================
:: MENU SISTEMA
:sistema
cls
echo ================= SISTEMA =================
echo 0 - Voltar
echo 1 - Reiniciar Computador
echo 2 - Lentidao (Limpeza + SFC)
echo 3 - Atualizar Group Policy
echo 4 - Processos com maior uso de CPU
echo 5 - Liberar acesso a compartilhamentos
echo 6 - Verificar disco (CHKDSK)
echo 7 - SFC /Scannow
echo 8 - DISM /RestoreHealth
echo 9 - Criar ponto de restauracao
echo 10 - Informacoes do sistema
echo 11 - Desfragmentar disco
echo 12 - Abrir gerenciador de tarefas
echo 13 - Limpar cache do Windows Update
echo 14 - Habilitar Alto Desempenho
echo 15 - Mostrar drivers com problemas
echo 16 - Relatorio de bateria
echo ===========================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" shutdown /r /t 0
if "%opcao%"=="2" goto lentidao
if "%opcao%"=="3" gpupdate /force & pause & goto sistema
if "%opcao%"=="4" wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime | sort & pause & goto sistema
if "%opcao%"=="5" powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false -Confirm:$false; Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Confirm:$false" & pause & goto sistema
if "%opcao%"=="6" chkdsk C: /f /r & pause & goto sistema
if "%opcao%"=="7" sfc /scannow & pause & goto sistema
if "%opcao%"=="8" DISM /Online /Cleanup-Image /RestoreHealth & pause & goto sistema
if "%opcao%"=="9" powershell -Command "Checkpoint-Computer -Description 'Ponto de Restauracao Manual'" & pause & goto sistema
if "%opcao%"=="10" systeminfo | more & pause & goto sistema
if "%opcao%"=="11" defrag C: & pause & goto sistema
if "%opcao%"=="12" taskmgr & goto sistema
if "%opcao%"=="13" net stop wuauserv & del /f /s /q "%SystemRoot%\SoftwareDistribution\*" & net start wuauserv & pause & goto sistema
if "%opcao%"=="14" powercfg -setactive SCHEME_MIN & pause & goto sistema
if "%opcao%"=="15" driverquery /si | findstr /i "problem" & pause & goto sistema
if "%opcao%"=="16" powercfg /batteryreport & start %userprofile%\battery-report.html & pause & goto sistema

goto sistema

:lentidao
cls
echo Limpando arquivos temporarios e otimizando sistema...
start "" "%temp%"
start "" "%SystemRoot%\SoftwareDistribution\Download"
start "" "%LocalAppData%\Microsoft\Windows\Explorer"
start "" "C:\Windows\Prefetch"
sfc /scannow
del /f /s /q "%temp%\*.*"
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*.*"
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\*.*"
del /f /s /q "C:\Windows\Prefetch\*.*"
pause
goto sistema

:: ==============================================
:: MENU INSTALADORES E DRIVERS
:instaladores
cls
echo ========== INSTALADORES ESSENCIAIS ==========
echo 0 - Voltar
echo --- Programas ---
echo 1 - Google Chrome
echo 2 - Mozilla Firefox
echo 3 - 7-Zip
echo 4 - VLC Media Player
echo 5 - Visual C++ Redistributable
echo 6 - .NET Framework 4.8
echo 7 - LibreOffice
echo 8 - Notepad++
echo 9 - AnyDesk
echo 10 - TeamViewer
echo --- Drivers ---
echo 11 - Intel Drivers
echo 12 - Realtek Drivers
echo 13 - NVIDIA Drivers
echo 14 - AMD Drivers
echo 15 - Windows Update (Drivers)
echo =============================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" winget install --id=Google.Chrome -e & pause & goto instaladores
if "%opcao%"=="2" winget install --id=Mozilla.Firefox -e & pause & goto instaladores
if "%opcao%"=="3" winget install --id=7zip.7zip -e & pause & goto instaladores
if "%opcao%"=="4" winget install --id=VideoLAN.VLC -e & pause & goto instaladores
if "%opcao%"=="5" winget install --id=Microsoft.VCRedist.2015+.x64 -e & pause & goto instaladores
if "%opcao%"=="6" winget install --id=Microsoft.DotNet.Framework.DeveloperPack_4.8 -e & pause & goto instaladores
if "%opcao%"=="7" winget install --id=LibreOffice.LibreOffice -e & pause & goto instaladores
if "%opcao%"=="8" winget install --id=Notepad++.Notepad++ -e & pause & goto instaladores
if "%opcao%"=="9" winget install --id=AnyDesk.AnyDesk -e & pause & goto instaladores
if "%opcao%"=="10" winget install --id=TeamViewer.TeamViewer -e & pause & goto instaladores
if "%opcao%"=="11" start "" "https://www.intel.com/content/www/us/en/support/detect.html" & pause & goto instaladores
if "%opcao%"=="12" start "" "https://www.realtek.com/en/downloads" & pause & goto instaladores
if "%opcao%"=="13" start "" "https://www.nvidia.com/Download/index.aspx" & pause & goto instaladores
if "%opcao%"=="14" start "" "https://www.amd.com/en/support" & pause & goto instaladores
if "%opcao%"=="15" start ms-settings:windowsupdate & pause & goto instaladores

goto instaladores

:: ==============================================
:sair
exit
