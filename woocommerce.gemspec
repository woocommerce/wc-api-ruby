# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubygems'
require 'woocommerce/version'

Gem::Specification.new do |s|
  s.name        = 'woocommerce'
  s.version     = WooCommerce::VERSION
  s.date        = '2015-07-14'

  s.summary     = 'A Ruby wrapper for the WooCommerce API'
  s.description = 'This gem provide a wrapper to deal with the WooCommerce REST API'
  s.license     = 'MIT'

  s.authors     = ['Claudio Sanches']
  s.files       = Dir['lib/woocommerce.rb', 'lib/woocommerce/*.rb']
  s.homepage    = 'https://github.com/woothemes/wc-api-ruby'

  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[README.md LICENSE]
end
