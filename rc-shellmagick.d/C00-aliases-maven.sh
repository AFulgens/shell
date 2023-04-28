#!/bin/sh

echo ""

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping aliases for Maven (no pom.xml found)[0m"
	return
fi

echo "[2m[3mRegistering aliases for Maven[0m"

# mv is taken 🙄
alias mav='mvn verify'
alias mavskip='mvn verify -DskipTests=true'
alias macv='mvn clean verify'
alias macvskip='mvn clean verify -DskipTests=true'

alias mdl='mvn dependency:list'
alias mdt='mvn dependency:tree'

alias mi='mvn install'
alias miskip='mvn install -DskipTests=true'
alias mci='mvn clean install'
alias mciskip='mvn clean install -DskipTests=true'

alias mwasp='mvn dependency-check:check -Powasp-dependency-check'
alias mtest='mvn test'
alias mtestint='mvn test -Pintegration-tests'
alias mtestpit='mvn test -Pmutation-tests org.pitest:pitest-maven:mutationCoverage'
alias pitreport='cygstart target/pit-reports/index.html'

alias mdown='mvn dependency:sources dependency:resolve'
alias mdowndoc='mvn depenedency:sources dependency:resolve -Dclassifier=javadoc'

# Note: '*' port is needed for JDK 11 and above
alias debugmavensuspend='export MAVEN_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:${MAVEN_DEBUG_PORT}"'
alias        debugmaven='export MAVEN_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:${MAVEN_DEBUG_PORT}"'
alias          runmaven='export MAVEN_OPTS=""'
runmaven
