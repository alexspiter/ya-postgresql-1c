FROM ubuntu:bionic

LABEL maintainer.base="team@silverbulleters.org"

ARG pgtag=
ARG pgversion=

ENV DEBIAN_FRONTEND=noninteractive

ENV PG_APP_HOME="/etc/docker-postgresql"\
    PG_TAG=$pgtag \
    PG_VERSION=$pgversion \
    PG_USER=postgres \
    PG_HOME=/var/lib/pgpro/${PG_VERSION} \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql \
    PG_CERTDIR=/etc/postgresql/certs

ENV PG_BINDIR=/opt/pgpro/${PG_VERSION}/bin \
    PG_DATADIR=${PG_HOME}/${PG_VERSION}/data \
    PG_WAL=${PG_HOME}/pg_xlog \
    PG_TEMPTBLSPC=${PG_HOME}/temptblspc \
    PG_V81C_DATA=${PG_HOME}/v81c_data \
    PG_V81C_INDEX=${PG_HOME}/v81c_index 

RUN apt-get update && apt-get install -y locales gnupg2 wget \
        && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8 \
        && update-locale LANG=ru_RU.UTF-8

#TODO add en_US locale
ENV LANG ru_RU.UTF-8
ENV LC_MESSAGES "POSIX"

ADD tools/postgrepinning /etc/apt/preferences.d/postgres

RUN wget -O - http://1c.postgrespro.ru/keys/GPG-KEY-POSTGRESPRO-1C | apt-key add -
RUN wget -O - https://repo.postgrespro.ru/mamonsu/keys/GPG-KEY-MAMONSU | apt-key add -

RUN echo deb http://repo.postgrespro.ru/1c-archive/pg1c-${PG_TAG}/ubuntu/ bionic main > /etc/apt/sources.list.d/postgrespro-1c.list
RUN echo deb https://repo.postgrespro.ru/mamonsu/latest/deb/ bionic main-bionic > /etc/apt/sources.list.d/mamonsu.list

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl acl wget \
      postgrespro-${PG_VERSION} \
      postgrespro-${PG_VERSION}-client \
      postgrespro-${PG_VERSION}-contrib \
      mamonsu

RUN service postgrespro-${PG_VERSION} start

RUN ls -al ${PG_HOME}/${PG_VERSION}/

RUN cat ${PG_HOME}/${PG_VERSION}/initd*.log

RUN ls ${PG_DATADIR}

WORKDIR /tmp

WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y \
    gcc \
    jq \
    make \
    sudo \
    postgrespro-${PG_VERSION}-plpython

RUN apt-get install -y postgrespro-${PG_VERSION}-dev

RUN wget -O- $(wget -O- https://api.github.com/repos/powa-team/powa-archivist/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/powa-team/pg_qualstats/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/powa-team/pg_stat_kcache/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/HypoPG/hypopg/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/rjuju/pg_track_settings/releases/latest|jq -r '.tarball_url') | tar -xzf - \  
    && wget -O- $(wget -O- https://api.github.com/repos/postgrespro/pg_wait_sampling/releases/latest|jq -r '.tarball_url') | tar -xzf - \  
    && wget -O- $(wget -O- https://api.github.com/repos/reorg/pg_repack/tags|jq -r '.[0].tarball_url') | tar -xzf -

RUN /opt/pgpro/${PG_VERSION}/bin/pg-wrapper links update

RUN for f in $(ls); do cd $f; ls -al .; make USE_PGXS=1 install; cd ..; rm    -rf $f; done \
    && apt-get purge -y --auto-remove curl gcc jq make postgrespro-${PG_VERSION}-dev wget

 RUN rm -rf ${PG_HOME} \
 && rm -rf /var/lib/apt/lists/*

COPY runtime/ ${PG_APP_HOME}/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 5432/tcp
VOLUME ["${PG_HOME}", "${PG_RUNDIR}", "${PG_LOGDIR}", "${PG_DATADIR}"]
VOLUME ["${PG_TEMPTBLSPC}", "${PG_V81C_DATA}", "${PG_V81C_INDEX}"]
WORKDIR ${PG_HOME}
ENTRYPOINT ["/sbin/entrypoint.sh"] 
