@echo off
cls

REM General note: In case you are "playing around" with windows environment variables, you will have to restart CMD after each change.
REM In case you are using Windows Terminal, you have to restart the whole application, closing and opening tabs won't re-inject the changes.

REM Usually I work in an enterprise environment with some kind of internal repository
REM and this repository is usually hidden behind authentication. The best-practice
REM pattern seems to be to save the username and the password as environment variables
REM PLEASE NOTE: the expectation is that the password is encrypted, see for example
REM the maven setup part of this repository!
if not defined ARTIFACTORY_USERNAME set ARTIFACTORY_USERNAME=%ARTIFACTORY_USERNAME%
if not defined ARTIFACTORY_PASSWORD set ARTIFACTORY_PASSWORD=%ARTIFACTORY_PASSWORD%
if not defined ARTIFACTORY_URL set ARTIFACTORY_URL=%ARTIFACTORY_URL%
REM These paths should be in Windows format!
REM JAVA_BASE: A base directory for multiple JDKs (e.g., downloaded via IntelliJ into %UserProfile%\.jdks)
REM JAVA_HOME: Path to the root of a specific JDK, which should always be used (regardless of what is in the project's POM)
REM MAVEN_SETTINGS_FILE: By default should be set to %UserProfile%\.m2\settings.xml, which should be a copy of this project's maven/settings.xml
if not defined JAVA_BASE set JAVA_BASE=%JAVA_BASE%
if not defined JAVA_HOME set JAVA_HOME=%JAVA_HOME%
if not defined MAVEN_SETTINGS_FILE set MAVEN_SETTINGS_FILE=%MAVEN_SETTINGS_FILE%

REM We pivot instantly away from Windows CMD
SET BOOTSTRAP_SCRIPT=C:\Projects\tools\shellmagick\rc-shellmagick.d-bootstrap.sh

REM The pivot works automatigically, thanks to our .bash_profile
C:\cygwin64\bin\bash.exe --login -i

REM Please note: sometimes (but sometimes not) you will get a "Terminate batch job? (Y/N)"
REM prompt, when closing your terminal and thus returning to the enclosing Windows CMD.
REM There is no easy workaround for this, at least none that I found until now.