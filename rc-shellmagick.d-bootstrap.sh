#!/bin/sh

# This script will iterate over all the "projects", which are in the given
# directory, set up through the setup environment variables
# A "project" currently is expected as follows
# - it's a git project (i.e., has a `.git` subdirectory)
# - it is not ignored (i.e., does not have the marker file `.git/.ignore-shellmagick`)

######################
# BASE CUSTOMIZATION #
######################

export RC_SHELLMAGICK_ROOT_PATH="C:\projects"
if $cygwin; then export RC_SHELLMAGICK_ROOT_PATH="$(cygpath --path --unix "${RC_SHELLMAGICK_ROOT_PATH}")"; fi

export PATH_TOOLS="${RC_SHELLMAGICK_ROOT_PATH}/tools"
export GIT_SUBPATH="git"
export SHELLMAGICK_SUBPATH="shellmagick"
export SHELLMAGICK_PATH="${PATH_TOOLS}/${SHELLMAGICK_SUBPATH}"
export RC_SHELLMAGICK_PATH="${SHELLMAGICK_PATH}/rc-shellmagick.d"

project_default="sandbox"
# Make sure that this is unique and does not appear in $selectors
selector_default="@"
# You are on your own here, some characters, like `[` will make this go kaput
selectors="12345qwertasdfgzxcvb67890yuiophjkl;nm,.QWERTASDFGZXCVBYUIOPHJKL:NM<>?-=_+~"

######################
# TOOL CUSTOMIZATION #
######################

# rc-shellmagick.d/C00-global-githooks.sh
#export GLOBAL_GITHOOKS_DO_NOT_OVERRIDE=1

# rc-shellmagick.d/C01-global-fork-commands.sh
export GLOBAL_FORK_USE=1 
#export GLOBAL_FORK_DO_NOT_OVERRIDE=1 

# rc-shellmagick.d/P00-set-git.sh, ${APPDATA} is cygwin-ized %AppData%
export GIT_HOME=$(cygpath --path --unix "${APPDATA}/../Local/Fork/gitInstance/2.39.1")

# rc-shellmagick.d/P01-setup-java.sh
if [[ ! -z ${JAVA_BASE+x} ]]; then
	export JAVA_BASE=$(cygpath --path --unix "${JAVA_BASE}")
fi
if [[ ! -z ${JAVA_HOME+x} ]]; then
	export JAVA_HOME=$(cygpath --path --unix "${JAVA_HOME}")
fi

# rc-shellmagick.d/P10-setup-spring-boot.sh
export SETUP_SPRING_BOOT=1

# global-githooks/commit-msg
#export COMMIT_SUBJECT_LINE_LENGTH=50 # value is used, default is 50
#export COMMIT_BODY_LINE_LENGTH=72 # value used, default is 72

# global-githooks/pre-commit
#export COMMIT_ALLOW_UTF32_BOM=1
#export COMMIT_ALLOW_UTF16_BOM=1
#export COMMIT_ALLOW_UTF8_BOM=1
#export COMMIT_ALLOW_FIXME=1
#export COMMIT_ALLOW_TODO=1
#export COMMIT_ALLOW_XXX=1
#export COMMIT_ALLOW_BINARY=1

#########
# MAGIC #
#########
# After this part you should not need to make changes, unless you want to change
# the logic of how projects are to be found

counter_selector=0
declare -A map_projects
count_projects=$(ls -d ${RC_SHELLMAGICK_ROOT_PATH}/${GIT_SUBPATH}/* 2>/dev/null | wc -l 2>/dev/null)
counter_projects=0
counter_projects_found=0
counter_projects_nongit=0
counter_projects_ignored=0

if [[ ${count_projects} -eq 0 ]]; then
	echo "[1m[31mThe directory set up for your projects does not exists, defaulting to the ShellMagick RC directory[0m"
	export PROJECT_NAME="${SHELLMAGICK_SUBPATH}"
	export PROJECT_PATH="${SHELLMAGICK_PATH}"
	export CURRENT_DIRECTORY="${SHELLMAGICK_PATH}"
else
	printf "00/%02d folders scanned\r" ${count_projects}
	for dir in $(ls -d ${RC_SHELLMAGICK_ROOT_PATH}/${GIT_SUBPATH}/*); do
		counter_projects=$((counter_projects+1))
		printf "%02d/%02d folders scanned\r" ${counter_projects} ${count_projects}

		# Is it a git repository?
		if [[ -d "${dir}/.git" ]]; then
			# Is it ignored?
			if [[ -f "${dir}/.git/.ignore-shellmagick" ]]; then
				counter_projects_ignored=$((counter_projects_ignored+1))
				continue
			fi

			# Do we have more projects than keys to select one?
			if [[ ${counter_selector} -eq ${#selectors} ]]; then
				echo ""
				echo "Currently we only support ${#selectors} distinct projects"
				echo "Maybe take a break and don't work on so many stuff in parallel? :]"
				echo "Burnout is real, take care of yourself!"
				break
			fi

			current_key=${selectors:$counter_selector:1}
			current_project=$(basename ${dir})
			if [[ ${project_default} == ${current_project} ]]; then
				# skipping default project, so that it's not listed twice
				:
			else
				map_projects[$current_key]=$current_project
				counter_projects_found=$((counter_projects_found+1))
				counter_selector=$((counter_selector+1))
			fi
		else
			counter_projects_nongit=$((counter_projects_nongit+1))
		fi
	done
	echo ""
	echo "$((${counter_projects_found}+1)) projects found (${counter_projects_ignored} explicitly ignored and ${counter_projects_nongit} are not git repos)"

	for (( i=0; i<${#selectors}; ++i )); do
		current_key=${selectors:$i:1}
		if [[ -v map_projects[${current_key}] ]]; then
			echo "(${current_key})" ${map_projects[${current_key}]}
		fi
	done
	echo "(${selector_default})" ${project_default}
	while true; do
		read -p "Select a project: " selected_project

		if [[ "${selector_default}" == ${selected_project} ]]; then
			export PROJECT_NAME="${project_default}"
		else
			if [[ -v map_projects[${selected_project}] ]]; then
				export PROJECT_NAME="${map_projects[${selected_project}]}"
			else
				echo "The key ${selected_project} is not bound to any project found, please select one from the list above!"
				continue
			fi
		fi
		break
	done
	export PROJECT_PATH="${RC_SHELLMAGICK_ROOT_PATH}/${GIT_SUBPATH}/${PROJECT_NAME}"
	export CURRENT_DIRECTORY="${PROJECT_PATH}"
fi

# TODO: check whether directory exists
cd "${CURRENT_DIRECTORY}"
source "${SHELLMAGICK_PATH}/rc-shellmagick.d.sh"
