FROM debian:stretch

RUN apt-get update && apt-get install -y \
	curl \
	unzip \
	&& rm -rf /var/lib/apt/lists/*

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/additional/sapjvm-8.1.052-linux-x64.zip \
	-o sapjvm8.zip \
	&& \
	unzip sapjvm8.zip \
	&& \
	rm sapjvm8.zip

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/sdk/neo-java-web-sdk-3.78.15.zip \
	-o neo-java-web-sdk.zip \
	&& \
	mkdir neo-java-web-sdk \
	&& \
	unzip neo-java-web-sdk.zip -d neo-java-web-sdk \
	&& \
	rm neo-java-web-sdk.zip

COPY src/* /scripts/
RUN chmod a+x /scripts/*

ENV JAVA_HOME=/sapjvm_8
ENV SAPJVM_HOME=/sapjvm_8
ENV CATALINA_HOME=/neo-java-web-sdk/repository/.archive
ENV CATALINA_BASE=/tomcat
ENV UMASK=0000

EXPOSE 8080
EXPOSE 8443
EXPOSE 8009

CMD ["/scripts/tomcat.sh", "run"]
