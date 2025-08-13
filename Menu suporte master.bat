@echo off
:: ==== Rodar como Administrador ====
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo.
    echo Este script precisa ser executado como Administrador!
    pause
    exit
)

title MENU MASTER DE SUPORTE TECNICO - SOFTWAVE SOLUTIONS
color 0A

:menu
cls
echo ==================================================
echo             MENU MASTER SUPORTE TECNICO
echo ==================================================
echo 0 - Sair
echo 1 - Rede 
echo 2 - Impressoras 
echo 3 - Sistema 
echo 4 - Utilitarios Avancados
echo ==================================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto sair
if "%opcao%"=="1" goto rede 
if "%opcao%"=="2" goto impressoras
if "%opcao%"=="3" goto sistema
if "%opcao%"=="4" goto utilitarios

echo Opcao invalida.
pause
goto menu

:: ======== REDE ========
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

:: ======== IMPRESSORAS ========
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

:: ======== SISTEMA ========
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

:: ======== UTILITARIOS AVANCADOS ========
:utilitarios
cls
echo ========== UTILITARIOS AVANCADOS ==========
echo 0 - Voltar
echo 1 - Limpeza Avancada (Temp + Prefetch)
echo 2 - Mostrar programas instalados
echo 3 - Reinstalar apps do Windows
echo 4 - Mostrar espaco livre no disco
echo 5 - Mostrar arquivos grandes (+100MB)
echo 6 - Reiniciar Windows Explorer
echo 7 - Liberar RAM
echo 8 - Mostrar processos em segundo plano
echo 9 - Testar velocidade de disco
echo 10 - Ativar/Desativar Firewall
echo ===========================================
set /p opcao=Escolha uma opcao: 

if "%opcao%"=="0" goto menu
if "%opcao%"=="1" del /q/f/s %TEMP%\* & del /q/f/s C:\Windows\Prefetch\* & echo Limpou geral! & pause & goto utilitarios
if "%opcao%"=="2" powershell "Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Out-Host" & pause & goto utilitarios
if "%opcao%"=="3" powershell "Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" & pause & goto utilitarios
if "%opcao%"=="4" wmic logicaldisk get size,freespace,caption & pause & goto utilitarios
if "%opcao%"=="5" powershell "Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | Where-Object { !$_.PSIsContainer -and $_.Length -gt 100MB } | Sort-Object Length -Descending | Select-Object Name, Length, Directory | Out-Host" & pause & goto utilitarios
if "%opcao%"=="6" taskkill /f /im explorer.exe & start explorer.exe & goto utilitarios
if "%opcao%"=="7" powershell "Clear-RecycleBin -Force; [System.GC]::Collect()" & pause & goto utilitarios
if "%opcao%"=="8" powershell "Get-Process | Where-Object {$_.MainWindowTitle -eq ''} | Out-GridView" & pause & goto utilitarios
if "%opcao%"=="9" winsat disk & pause & goto utilitarios
if "%opcao%"=="10" netsh advfirewall set allprofiles state off & pause & goto utilitarios

goto utilitarios

:sair
exit

:: ======== LENTIDAO OTIMIZACAO ========
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
