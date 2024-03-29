FROM ruby:3.2.2-alpine

ENV LANG=C.UTF-8 TZ=Asia/Tokyo

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apk update && \
    apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs tzdata file imagemagick mysql-dev && \
    apk add --virtual build-packages --no-cache build-base curl-dev

# 作業ディレクトリの指定
WORKDIR /rails-api
COPY Gemfile /rails-api/Gemfile
COPY Gemfile.lock /rails-api/Gemfile.lock

RUN bundle install

RUN apk del build-packages

COPY . /rails-api