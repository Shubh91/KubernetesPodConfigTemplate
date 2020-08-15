FROM openjdk:8

RUN mkdir /opt/cdbg
RUN wget -qO- https://storage.googleapis.com/cloud-debugger/compute-java/debian-wheezy/cdbg_java_agent_service_account.tar.gz | \
    tar xvz -C /opt/cdbg

COPY ./target/*.jar ./

ARG tag
ENV TAG=${tag}

EXPOSE 8080
CMD java -agentpath:/opt/cdbg/cdbg_java_agent.so \
             -Dcom.google.cdbg.module=sales \
             -Dcom.google.cdbg.version=${TAG} \
             -jar -Xms1024M -Xmx1024M ./*.jar
