# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.3-3

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bash_profile file

# source the system-wide basrc if exists
if [ -f /etc/bash.bashrc ]; then
	source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
	source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
# 	PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
# 	MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
# 	INFOPATH="${HOME}/info:${INFOPATH}"
# fi

# Security first, this should anyways be the default, but best to "enforce" it
umask 022

# Although appending instead of overwriting causes some disk overhead, with
# SSDs I/O latency is not a problem anymore, and this won't kill your SSD...
# BUT: it will make sure that when you have multiple terminals open in parallel
# you don't lose any of those precious commands you googled with a lot of sweat
# and copy-pasted into your command line.
shopt -s histappend

# We want to make extra sure that no history gets lost, and want to use a
# useful prompt.
PROMPT_COMMAND="history -a;rc1_prompt;$PROMPT_COMMAND"

# Command line history takes surprisingly little amount of space.
# With ignoring duplicates, 2**14 entries should be more than enough for a couple
# months (or years) of work on the terminal.
HISTCONTROL="ignoredups"
HISTSIZE=16384

# Enhance the default prompt by auto-adjusting title for the window based on PWD
function default_prompt() {
	export PS1="\[\e0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[\0;m\]\n\$ "
}

# We pivot to a more useful prompt than the default
# The idea comes from Tom Duff and is based on the rc(1) shell default
# I've got the idea from Kate: https://twitter.com/thingskatedid/status/1316081075043463170
# Hint: Cygwin/Windows Terminal struggles with the history (up-arrow) in case there is too much
#       coloring going on. Best to leave the default case without any colors.
function rc1_prompt() {
	if [ $? -eq 0 ]; then
		PS1="; "
	else
		PS1="\e[0;31m;\e[0;m"
	fi
}

# Note: this way we fix the window title to the "base" directory in which the terminal
#       has been started (default_prompt sets it one time, and here we override the behaviour)
export PS1='$(rc1_prompt)'

# Helper function for setting the title of the window in case we ever want to, and some
# windower solution need to have it in the setup pretty early on, best not to wait until
# the init scripts are running, but define it already in the profile.
function settitle() {
	echo -ne "\e]0;${1}\a"
}

# OS specific support, shamelessly copied from Maven Wrapper https://maven.apache.org/wrapper/
cygwin=false;
darwin=false;
mingw=false
case "`uname`" in
	CYGWIN*) cygwin=true ;;
	MINGW*) mingw=true;;
	Darwin*) darwin=true
		# Use /usr/libexec/java_home if available, otherwise fall back to /Library/Java/Home
		# See https://developer.apple.com/library/mac/qa/qa1170/_index.html
		if [ -z "$JAVA_HOME" ]; then
			if [ -x "/usr/libexec/java_home" ]; then
					JAVA_HOME="`/usr/libexec/java_home`"; export JAVA_HOME
			else
					JAVA_HOME="/Library/Java/Home"; export JAVA_HOME
			fi
		fi
	;;
esac

# Here one shouldn't use [[ ! -z ${!VAR+X} ]] because on Windows it will cause
# bad substitution erros, because of the backslashes...
if [[ ! "${CURRENT_DIRECTORY}" =~ ^$ ]]; then
	if $cygwin; then
		cd "$(cygpath --path --unix "${CURRENT_DIRECTORY}")"
	else
		cd "${CURRENT_DIRECTORY}"
	fi
fi

if [[ ! "${BOOTSTRAP_SCRIPT}" =~ ^$ ]]; then
	if $cygwin; then
		source "$(cygpath --path --unix "${BOOTSTRAP_SCRIPT}")"
	else
		source "${BOOTSTRAP_SCRIPT}"
	fi
fi
