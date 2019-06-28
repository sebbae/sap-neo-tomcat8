FROM debian:stretch

RUN apt-get update && apt-get install -y \
	curl \
	unzip \
	coreutils \
	&& rm -rf /var/lib/apt/lists/*

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/additional/sapjvm-8.1.055-linux-x64.zip \
	-o sapjvm8.zip \
	&& \
	unzip sapjvm8.zip \
	&& \
	rm sapjvm8.zip

RUN curl \
	--cookie "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" \
	https://tools.hana.ondemand.com/sdk/neo-java-web-sdk-3.83.3.zip \
	-o neo-java-web-sdk.zip \
	&& \
	mkdir neo-java-web-sdk \
	&& \
	unzip neo-java-web-sdk.zip -d neo-java-web-sdk \
	&& \
	rm neo-java-web-sdk.zip


COPY src/scripts /scripts/
RUN chmod a+x /scripts/*

ENV JAVA_HOME=/sapjvm_8
ENV SAPJVM_HOME=/sapjvm_8
ENV UMASK=0000

RUN /scripts/run.sh init
COPY src/cfg/conf/* /tomcat/conf/

EXPOSE 8080
EXPOSE 8443
EXPOSE 8009

CMD ["/scripts/run.sh", "run"]
