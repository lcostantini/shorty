namespace 'shorten' do
  # post '/', to: 'shorten_urls::create'
  # get '/:shortcode', to: 'shorten_urls::show'
  # get '/:shortcode/stats', to: 'shorten_urls::stats'
  post '/', to: 'shorten_urls#create'
end
