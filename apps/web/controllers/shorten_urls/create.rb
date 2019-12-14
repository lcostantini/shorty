module Web
  module Controllers
    module ShortenUrls
      class Create
        include Web::Action
        accept :json

        params do
          required(:url).filled(:str?)
          optional(:shortcode).filled(:str?, format?: /^[0-9a-zA-Z_]{4,}$/)
        end

        def call(params)
          self.headers.merge!({'Content-Type' => 'application/json'})

          if params.valid?
            require 'pry'; binding.pry
            params[:shortcode] ||= generate_code

            status 201, {shortcode: params[:shortcode]}
          else
            error_code = 422 if params.errors.key?(:shortcode)

            status (error_code || 400), {error: params.error_messages[0]}
          end
        end

        private

        def generate_code
          SecureRandom.urlsafe_base64(6, true).tr('-=', '_')
        end
      end
    end
  end
end
