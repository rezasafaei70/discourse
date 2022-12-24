FROM rails

WORKDIR /usr/src/app

ENV DISCOURSE_VERSION v2.9.0.beta14
RUN apt update && apt install -y git 
RUN git clone  https://github.com/discourse/discourse.git /usr/src/app \
  && bundle install --deployment --without test --without development

RUN apt-get update && apt-get install -y --no-install-recommends imagemagick libxml2 \
  && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV production
ENV DISCOURSE_DB_HOST postgres
ENV DISCOURSE_REDIS_HOST redis
ENV DISCOURSE_SERVE_STATIC_ASSETS true

EXPOSE 3000
CMD ["rails", "server"]
