FROM aditirvan/phusion-passenger-nginx:2.7.4-alpine as builder

ENV APP_HOME="/usr/src/app"
WORKDIR ${APP_HOME}

COPY Gemfile* ./
RUN mkdir .bundle \
    && touch .bundle/config \
    && apk add --no-cache build-base mariadb-dev tzdata freetds freetds-dev \
    && gem install --no-update-source --update bundler \
    && bundle install -j 4 --retry 3 \
    && rm -rf /usr/local/bundle/cache \
    && find /usr/local/bundle/gems -name *.c -delete \
    && find /usr/local/bundle/gems -name *.o -delete

FROM aditirvan/phusion-passenger-nginx:2.7.4-alpine
ENV APP_HOME="/usr/src/app"
WORKDIR ${APP_HOME}

COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder $APP_HOME/.bundle/config .bundle/config
COPY . .
COPY default.conf /etc/nginx/conf.d/default.conf

RUN apk add --no-cache mariadb-dev \
    && mkdir -p tmp/pids/ \
    && chmod 775 ${APP_HOME}

EXPOSE 80

CMD ./docker-entrypoint.sh