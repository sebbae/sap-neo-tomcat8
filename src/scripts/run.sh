#!/bin/bash
NEO_SDK=/neo-java-web-sdk
NEO=${NEO_SDK}/tools/neo.sh
KEYTOOL=${JAVA_HOME}/bin/keytool
TOMCAT_HOME=/tomcat
WEBAPPS=/webapps

init() {
	${NEO} install-local -l ${TOMCAT_HOME}
	${KEYTOOL} \
		-genkey \
		-dname "CN=sap-neo-tomcat8" \
		-keyalg "RSA" \
		-alias tomcat \
		-storetype PKCS12 \
		-storepass tomcat \
		-keystore ${TOMCAT_HOME}/keystore.pfx
}

run() {
	${NEO} deploy-local -l ${TOMCAT_HOME} -s ${WEBAPPS}
	${NEO} start-local -l ${TOMCAT_HOME}
	tail -f ${TOMCAT_HOME}/log/ljs_trace.log
}

usage() {
	echo "available commands:"
	echo "  run - deploy war's and start tomcat"
	echo "  init - initialize server config"
}

case $1 in
	run)
		run
		;;
	init)
		init
		;;
	*)
		usage
		;;
esac
