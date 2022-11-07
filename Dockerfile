FROM icr.io/appc-dev/ace-server:latest

ENV SUMMARY="Integration Server for App Connect Enterprise" \
    DESCRIPTION="Integration Server for App Connect Enterprise" \
    PRODNAME="AppConnectEnterprise" \
    COMPNAME="IntegrationServer" \
    LICENSE="accept" \
    LOG_FORMAT="basic" \
    ENV="MVP"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Integration Server for App Connect Enterprise" \
      io.k8s.env="$ENV" \
      io.openshift.tags="$PRODNAME,$COMPNAME,$ENV" \
      com.redhat.component="$PRODNAME-$COMPNAME" \
      name="$PRODNAME/$COMPNAME" \
      version="latest"
      
COPY NewOrdersService /home/aceuser/NewOrdersService
RUN mkdir /home/aceuser/bars && \
        source /opt/ibm/ace-12/server/bin/mqsiprofile && \
        /opt/ibm/ace-12/server/bin/mqsipackagebar -a bars/NewOrdersService.bar -k NewOrdersService && \
        ace_compile_bars.sh && \
        mv -v bars /home/aceuser/initial-config/bars        
USER 0
RUN chmod -R 777 /home/aceuser/initial-config/bars && \
    chmod -R 777 /home/aceuser/ace-server/run/NewOrdersService
    
USER aceuser
