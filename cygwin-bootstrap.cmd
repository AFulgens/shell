@echo off
cls

REM Usually I work in an enterprise environment with some kind of internal repository
REM and this repository is usually hidden behind authentication. The best-practice
REM pattern seems to be to save the username and the password as environment variables
REM PLEASE NOTE: the expectation is that the password is encrypted, see for example
REM the maven setup part of this repository!
if not defined ARTIFACTORY_USERNAME set ARTIFACTORY_USERNAME=%ARTIFACTORY_USERNAME%
if not defined ARTIFACTORY_PASSWORD set ARTIFACTORY_PASSWORD=%ARTIFACTORY_PASSWORD%

REM We pivot instantly away from Windows CMD
SET BOOTSTRAP_SCRIPT=C:\Projects\tools\shellmagick\rc-shellmagick.d-bootstrap.sh

REM The pivot works automatigically, thanks to our .bash_profile
C:\cygwin64\bin\bash.exe --login -i

REM Please note: sometimes (but sometimes not) you will get a "Terminate batch job? (Y/N)"
REM prompt, when closing your terminal and thus returning to the enclosing Windows CMD.
REM There is no easy workaround for this, at least none that I found until now.