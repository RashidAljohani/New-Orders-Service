#FROM quay.io/raljohani/ace-developer:12.0.1.0-r3
FROM icr.io/appc-dev/ace-server@sha256:0a343dc13136a2ea02fbfdf183eada88c60df254acff9bcf8373484038c93ce9

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
      version="12.0.1.0-r3"

COPY NewOrdersService /home/aceuser/NewOrdersService
RUN mkdir /home/aceuser/bars && \
        source /opt/ibm/ace-12/server/bin/mqsiprofile && \
        /opt/ibm/ace-12/server/bin/mqsipackagebar -a bars/NewOrdersService.bar -k NewOrdersService && \
        ace_compile_bars.sh && \
        chmod -R 777 /home/aceuser/ace-server/run/NewOrdersService
