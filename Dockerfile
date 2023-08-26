FROM ruby:3.1.2

ENV LANG C.UTF-8
# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリの指定
RUN mkdir /rails-api
WORKDIR /rails-api
COPY Gemfile /rails-api/Gemfile
COPY Gemfile.lock /rails-api/Gemfile.lock

RUN bundle install

COPY . /rails-api