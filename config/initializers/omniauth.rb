require 'omni_auth/strategies/fhs'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :Fhs,
           '_9JtDGaqPJH8Ke8rbAh1Gadl7komwhDN1lnI142frkk',
           'mjk2OwQ2rBxJgoqbHDUmDWcs7q4S08JS9-m8ZW2_gCo',
           { name: 'Fhs', scope: 'public identity' }
end

OmniAuth.config.logger = Rails.logger
