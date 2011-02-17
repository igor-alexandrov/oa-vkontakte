require 'omniauth/vkontakte'

if defined?(Rails)
  ActionController::Base.helper OmniAuth::Strategies::Vkontakte::ViewHelper::PageHelper
end
