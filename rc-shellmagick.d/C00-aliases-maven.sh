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
alias macv='mvn clean verify -Punit-tests'
alias macvskip='mvn clean verify -DskipTests=true'

alias mdl='mvn dependency:list'
alias mdt='mvn dependency:tree'

alias mi='mvn install -Punit-tests'
alias miskip='mvn install -DskipTests=true'
alias mci='mvn clean install -Punit-tests'
alias mciskip='mvn clean install -DskipTests=true'

alias mwasp='mvn dependency-check:check -Powasp-dependency-check'
alias mtest='mvn test -Punit-tests'
alias mteste='mvn test -Punit-tests ${EXTRA_MVN_TEST_ARGUMENTS}'
alias mtestint='mvn verify -Pintegration-tests'
alias mtestinte='mvn verify -Pintegration-tests ${EXTRA_MVN_TEST_ARGUMENTS}'
alias mtestpit='mvn verify -Pmutation-tests org.pitest:pitest-maven:mutationCoverage'
alias mtestpit='mvn verify -Pmutation-tests org.pitest:pitest-maven:mutationCoverage ${EXTRA_MVN_TEST_ARGUMENTS}'
alias pitreport='cygstart target/pit-reports/index.html'

alias mdown='mvn dependency:sources dependency:resolve'
alias mdowndoc='mvn depenedency:sources dependency:resolve -Dclassifier=javadoc'

if [[ ! -z ${SONAR_HOST_URL+x} ]]; then
	if [[ ! -z ${SONAR_TOKEN+x} ]]; then
		alias msonar='mvn sonar:sonar -Dsonar.host.url=${SONAR_HOST_URL} -Dsonar.token=${SONAR_TOKEN} -Dsonar.branch.name=$(git rev-parse --abbrev-ref HEAD)'
	fi
fi


# Note: '*' port is needed for JDK 11 and above
alias debugmavensuspend='export MAVEN_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=*:${MAVEN_DEBUG_PORT}"'
alias        debugmaven='export MAVEN_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:${MAVEN_DEBUG_PORT}"'
alias          runmaven='export MAVEN_OPTS=""'
runmaven
