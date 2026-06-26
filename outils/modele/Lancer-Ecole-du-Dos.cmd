@echo off
chcp 65001 >nul
rem Ouvre le dashboard Ecole du Dos dans Microsoft Edge (hors-ligne)
start "" msedge "%~dp0Ecole-du-Dos.html"
rem Si Edge n'est pas trouve, ouvre dans le navigateur par defaut :
if errorlevel 1 start "" "%~dp0Ecole-du-Dos.html"
