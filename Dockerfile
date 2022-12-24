FROM rails

WORKDIR /usr/src/app

ENV DISCOURSE_VERSION v2.9.0.beta14
RUN  apt-get update \
  && apt install -y zip unzip \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN wget  https://github.com/discourse/discourse/archive/refs/tags/v2.9.0.beta14.zip && \
  unzip  /usr/src/app \
  && bundle install --deployment --without test --without development

RUN apt-get update && apt-get install -y --no-install-recommends imagemagick libxml2 \
  && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV production
ENV DISCOURSE_DB_HOST postgres
ENV DISCOURSE_REDIS_HOST redis
ENV DISCOURSE_SERVE_STATIC_ASSETS true

EXPOSE 3000
CMD ["rails", "server"]
