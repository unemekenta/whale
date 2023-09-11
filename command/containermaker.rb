# オブジェクトバケット作成用

require 'fog' #このプログラムはfogがインストールされている環境で動かしてね。

CONOHA_TENANT_NAME = ENV['CONOHA_TENANT_NAME']
CONOHA_USERNAME = ENV['CONOHA_USERNAME']
CONOHA_API_PASSWORD = ENV['CONOHA_API_PASSWORD']
CONOHA_API_AUTH_URL = ENV['CONOHA_API_AUTH_URL']
CONOHA_CONTAINER_NAME = ENV['CONOHA_CONTAINER_NAME']

service = Fog::Storage.new(
  provider: 'OpenStack',
  openstack_tenant: CONOHA_TENANT_NAME,
  openstack_username: CONOHA_USERNAME,
  openstack_api_key: CONOHA_API_PASSWORD,
  openstack_auth_url: CONOHA_API_AUTH_URL,
)

service.put_container(CONOHA_CONTAINER_NAME, public: true, headers: { 'X-Web-Mode' => 'true' })