require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fhs < OmniAuth::Strategies::OAuth2
      option :name, :Fhs
      option :client_options,
             {
               site: 'https://auth.projects.multimediatechnology.at',
               authorize_url: 'oauth/authorize'
             }

      uid { raw_info['id'] }

      info do
        prune!(
          {
            username: raw_info['username'],
            name: raw_info['name'],
            email: raw_info['email'],
            firstname: raw_info['firstname'],
            lastname: raw_info['lastname'],
            status: raw_info['status'],
            department: raw_info['department'],
            studies: raw_info['studies']
          }
        )
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
