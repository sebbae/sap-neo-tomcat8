#!/bin/sh
echo CATALINA_BASE is set to ${CATALINA_BASE}
echo CATALINA_HOME is set to ${CATALINA_HOME}

CATALINA_OPTS='
	-Djava.rmi.server.hostname=127.0.0.1 \
	-Dcom.sun.management.jmxremote= \
	-Dcom.sun.management.jmxremote.port=1812 \
	-Dcom.sun.management.jmxremote.ssl=false \
	-Dcom.sun.management.jmxremote.authenticate=false \
	-Djava.security.auth.login.config="${CATALINA_BASE}/config_master/com.sap.security.auth.service/java.login.config" \
	-Dpath.to.runtime.installation.folder="${CATALINA_BASE}" \
	-Dserver.config.home="${CATALINA_BASE}" \
	-Dcatalina.base="${CATALINA_BASE}" \
	-Dcatalina.home="${CATALINA_HOME}" \
	-Djava.endorsed.dirs="${CATALINA_HOME}/endorsed"
	'

umask 0000

init() {
	if [ ! -d ${CATALINA_BASE} ]; then
		mkdir -p ${CATALINA_BASE}
	fi

	mkdir ${CATALINA_BASE}/temp
	mkdir ${CATALINA_BASE}/log
	mkdir ${CATALINA_BASE}/conf
	cp -r ${CATALINA_HOME}/conf/catalina.policy ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/conf/catalina.properties ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/conf/server.xml ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/conf/context.xml ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/conf/tomcat-users.xml ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/conf/web.xml ${CATALINA_BASE}/conf/
	cp -r ${CATALINA_HOME}/config_master ${CATALINA_BASE}/
	chmod -R a+rw ${CATALINA_BASE}
}

run() {
	if [ ! -d "${CATALINA_BASE}"/conf ]; then
		echo "Init of ${CATALINA_BASE} required"
		init
	fi

	/bin/sh ${CATALINA_HOME}/bin/catalina.sh run 
}

usage() {
	echo "available commands:"
	echo "  run - start tomcat"
	echo "  init - initialize server config directory"
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
