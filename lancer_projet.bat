@echo off
chcp 65001 >nul 2>&1
cls
title RESERVATION VOITURE - Lancement

echo.
echo ============================================================
echo          PROJET RESERVATION VOITURE - Sprint 1
echo ============================================================
echo.

:: ============================================================
:: CONFIGURATION - Modifiez ici si necessaire
:: ============================================================
set TOMCAT_HOME=C:\apache-tomcat-11.0.14
set PROJECT_DIR=%~dp0
set FRONT_DIR=%PROJECT_DIR%reservation-frontoffice
set BACK_DIR=%PROJECT_DIR%reservation-backoffice

:: ============================================================
:: 1. NETTOYAGE
:: ============================================================
echo [96m[1/6] Nettoyage des processus existants...[0m
taskkill /F /IM java.exe >nul 2>&1
timeout /t 3 /nobreak >nul
echo [92m      OK[0m

:: ============================================================
:: 2. COMPILATION BACKOFFICE
:: ============================================================
echo [96m[2/6] Compilation du BackOffice...[0m
cd /d "%BACK_DIR%"
call mvn clean package -q -DskipTests 2>nul
if %ERRORLEVEL% neq 0 (
    echo [93m      WARN: Compilation BackOffice echouee, on continue...[0m
) else (
    echo [92m      Compilation OK[0m
    if exist "%TOMCAT_HOME%\webapps\reservation-backoffice.war" del /q "%TOMCAT_HOME%\webapps\reservation-backoffice.war"
    if exist "%TOMCAT_HOME%\webapps\reservation-backoffice" rmdir /s /q "%TOMCAT_HOME%\webapps\reservation-backoffice"
    copy /y "target\reservation-backoffice.war" "%TOMCAT_HOME%\webapps\" >nul
    echo [92m      WAR deploye dans Tomcat[0m
)

:: ============================================================
:: 3. DEMARRAGE TOMCAT
:: ============================================================
echo [96m[3/6] Demarrage de Tomcat...[0m
cd /d "%TOMCAT_HOME%\bin"
start /min "Tomcat-Server" startup.bat
timeout /t 8 /nobreak >nul
echo [92m      Tomcat demarre sur port 8080[0m

:: ============================================================
:: 4. DEMARRAGE FRONTOFFICE (Spring Boot sur port 8081)
:: ============================================================
echo [96m[4/6] Demarrage du FrontOffice Spring Boot...[0m
cd /d "%FRONT_DIR%"
start "FrontOffice-SpringBoot" cmd /c "title FrontOffice Spring Boot && mvn clean spring-boot:run 2>&1 && pause"

:: ============================================================
:: 5. ATTENTE DU DEMARRAGE
:: ============================================================
echo [96m[5/6] Attente du demarrage complet (60s max)...[0m
set /a count=0
:wait_loop
set /a count+=1
timeout /t 5 /nobreak >nul
powershell -Command "try { Invoke-WebRequest 'http://localhost:8081/' -TimeoutSec 3 -UseBasicParsing | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo [92m      FrontOffice pret! (%count% x 5s)[0m
    goto ready
)
if %count% lss 12 (
    echo [93m      Tentative %count%/12...[0m
    goto wait_loop
)
echo [91m      FrontOffice timeout - verifiez la fenetre Spring Boot[0m

:ready
:: ============================================================
:: 6. OUVERTURE DES NAVIGATEURS
:: ============================================================
echo [96m[6/6] Ouverture des navigateurs...[0m
start "" "http://localhost:8081/"
timeout /t 2 /nobreak >nul
start "" "http://localhost:8080/"

:: ============================================================
:: RESUME FINAL
:: ============================================================
echo.
echo ============================================================
echo                   PROJET LANCE !
echo ============================================================
echo.
echo   FrontOffice : http://localhost:8081/
echo   Tomcat      : http://localhost:8080/
echo   PostgreSQL  : localhost:5432/reservation_voiture
echo.
echo   Pages disponibles:
echo     - Accueil          : http://localhost:8081/
echo     - Reservations     : http://localhost:8081/reservations
echo     - Nouvelle Resa    : http://localhost:8081/nouvelle-reservation
echo     - API REST         : http://localhost:8081/api/reservations
echo.
echo ============================================================
echo Pour arreter : fermez cette fenetre + la fenetre FrontOffice
echo ============================================================
echo.
pause