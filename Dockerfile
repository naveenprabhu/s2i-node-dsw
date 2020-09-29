# dsw-rhel7
FROM registry.access.redhat.com/rhscl/s2i-base-rhel7:1

# This image provides a Node.JS environment you can use to run your Node.JS

LABEL maintainer="Naveen Arumugam<naveenprabhu.arumugam@optus.com.au>"

ENV NODEJS_VERSION=14 \
    NPM_RUN=start \
    NAME=nodejs \
    NPM_CONFIG_PREFIX=$HOME/.npm-global

LABEL io.k8s.description="Platform for building Micro services" \
     io.k8s.display-name="Node.js $NODEJS_VERSION" \
     io.openshift.expose-services="8080:http" \
     io.openshift.tags="builder,$NODEJS_VERSION,$NAME"

RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    yum -y install nodejs

COPY ./s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
