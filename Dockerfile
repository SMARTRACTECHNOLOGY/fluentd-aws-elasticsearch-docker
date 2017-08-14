FROM fluent/fluentd:v0.14.20-onbuild

MAINTAINER Smart Cosmos Core Platform Team
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root
RUN apk add --update --virtual .build-deps sudo build-base ruby-dev && \
    sudo gem install fluent-plugin-aws-elasticsearch-service && \
    sudo gem install fluent-plugin-kubernetes_metadata_filter && \
    sudo gem install fluent-plugin-multiline-parser && \
    sudo gem sources --clear-all && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* /home/fluent/.gem/ruby/2.3.0/cache/*.gem

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
