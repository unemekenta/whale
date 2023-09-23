require 'carrierwave/storage/abstract'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|

  CONOHA_TENANT_NAME = ENV['CONOHA_TENANT_NAME']
  CONOHA_USERNAME = ENV['CONOHA_USERNAME']
  CONOHA_API_PASSWORD = ENV['CONOHA_API_PASSWORD']
  CONOHA_API_AUTH_URL = ENV['CONOHA_API_AUTH_URL']
  CONOHA_CONTAINER_NAME = ENV['CONOHA_CONTAINER_NAME']
  CONOHA_ASSET_HOST = ENV['CONOHA_ASSET_HOST']

  if ENV['RAILS_ENV'] == 'local' || ENV['RAILS_ENV'] == 'docker-local'
    config.asset_host = ENV['CONOHA_ASSET_HOST']
    config.storage = :file
    config.cache_storage = :file
  else
    config.fog_credentials = {
      :provider => 'OpenStack',
      :openstack_tenant => CONOHA_TENANT_NAME,
      :openstack_username => CONOHA_USERNAME,
      :openstack_api_key => CONOHA_API_PASSWORD,
      :openstack_auth_url => CONOHA_API_AUTH_URL,
    }
    config.fog_directory = CONOHA_CONTAINER_NAME
    config.storage :fog
    config.asset_host = CONOHA_ASSET_HOST + '/' + CONOHA_CONTAINER_NAME
  end
end
