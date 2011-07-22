require 'omniauth/strategies/oauth'

require 'omniauth/vkontakte'
require 'omniauth/strategies/vkontakte/view_helper'

module OmniAuth
  class Configuration
    attr_accessor :vkontakte_app_id, :vkontakte_app_secret
  end
end

module OmniAuth
  module Strategies
    class Vkontakte < OmniAuth::Strategies::OAuth2
      # include OmniAuth::Strategy
      # include ViewHelper::PageHelper

      # def initialize(app, app_id, app_key, options = {})
      #   @options = options
      #   OmniAuth.config.vkontakte_app_id = app_id
      #   OmniAuth.config.vkontakte_app_key = app_key
      #   super(app, :vkontakte)
      # end
      def initialize(app, client_id = nil, client_secret = nil, options = {}, &block)
        OmniAuth.config.vkontakte_app_id = client_id
        OmniAuth.config.vkontakte_app_secret = client_secret
        
        client_options = {
          :site => 'http://api.vkontakte.ru',
          :authorize_url => 'http://api.vkontakte.ru/oauth/authorize',
          :access_token_url => 'https://api.vkontakte.ru/oauth/access_token'
        }
        super(app, :vkontakte, client_id, client_secret, client_options, options, &block)
      end
      
      # attr_reader :app_id
      
      def user_data
        @data ||= MultiJson.decode(@access_token.get('/me', {}, { "Accept-Language" => "en-us,en;"}))
      end
      
      # def request_phase
      #   Rack::Response.new(vkontakte_login_page).finish
      # end
      def request_phase
        options[:scope] ||= "offline"
        super
      end
      
      def callback_phase
        if request.params['error'] || request.params['error_reason']
          raise CallbackError.new(request.params['error'], request.params['error_description'] || request.params['error_reason'], request.params['error_uri'])
        end
        
        verifier = request.params['code']
        puts "!!!!!!!!!"
        puts client.access_token_url
        # @access_token = client.web_server.get_access_token(verifier, :redirect_uri => callback_url)
        response = client.request(:get, client.access_token_url, {'client_id' => OmniAuth.config.vkontakte_app_id, 'client_secret' => OmniAuth.config.vkontakte_app_secret, 'code' => verifier})
        
        puts "!!!!!"
        puts  MultiJson.decode(response)
        
      #   if @access_token.expires? && @access_token.expires_in <= 0
      #     client.request(:post, client.access_token_url, { 
      #         'client_id' => client_id,
      #         'grant_type' => 'refresh_token', 
      #         'client_secret' => client_secret,
      #         'refresh_token' => @access_token.refresh_token 
      #       })
      #     @access_token = client.web_server.get_access_token(verifier, :redirect_uri => callback_url)
      #   end
      #   
      #   super
      # rescue ::OAuth2::HTTPError, ::OAuth2::AccessDenied, CallbackError => e
      #   fail!(:invalid_credentials, e)
      # rescue ::MultiJson::DecodeError => e
      #   fail!(:invalid_response, e)
      end
            
      # def callback_phase
      #   app_cookie = request.cookies["vk_app_#{OmniAuth.config.vkontakte_app_id}"]
      #   return fail!(:invalid_credentials) unless app_cookie
      #   args = app_cookie.split("&")
      #   sig_index = args.index { |arg| arg =~ /^sig=/ }
      #   return fail!(:invalid_credentials) unless sig_index
      #   sig = args.delete_at(sig_index)
      #   puts Digest::MD5.new.hexdigest(args.sort.join('') + OmniAuth.config.vkontakte_app_key)
      #   puts sig
      #   return fail!(:invalid_credentials) unless Digest::MD5.new.hexdigest(args.sort.join('') + OmniAuth.config.vkontakte_app_key) == sig[4..-1]
      #   super
      # end

      def auth_hash
        OmniAuth::Utils.deep_merge(super(), {
          'uid' => request[:uid],
          'user_info' => {
            'nickname' => request[:nickname],
            'name' => "#{request[:first_name]} #{request[:last_name]}",
            'first_name' => request[:first_name],
            'last_name' => request[:last_name],
            'image' => request[:photo],
            'urls' => { 'Page' => 'http://vkontakte.ru/id' + request[:uid] }
          }
        })
      end
    end
  end
end
