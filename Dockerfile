FROM quay.io/rashid_aljohani/is-new-orders:12.0.3.0-r1

ENV SUMMARY="Integration Server for App Connect Enterprise" \
    DESCRIPTION="Integration Server for App Connect Enterprise" \
    PRODNAME="AppConnectEnterprise" \
    COMPNAME="IntegrationServer" \
    LICENSE="accept" \
    LOG_FORMAT="basic"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Integration Server for App Connect Enterprise" \
      io.openshift.tags="$PRODNAME,$COMPNAME" \
      com.redhat.component="$PRODNAME-$COMPNAME" \
      name="$PRODNAME/$COMPNAME" \
      version="12.0.3.0-r1"
      
COPY NewOrdersService /home/aceuser/NewOrdersService
RUN mkdir /home/aceuser/initial-config/bars && \
        source /opt/ibm/ace-12/server/bin/mqsiprofile && \
        /opt/ibm/ace-12/server/bin/mqsipackagebar -a initial-config/bars/NewOrdersService.bar -k NewOrdersService && \
        ace_compile_bars.sh && \
        chmod -R 777 /home/aceuser/initial-config/bars
