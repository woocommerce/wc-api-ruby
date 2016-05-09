# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubygems"
require "woocommerce_api/version"


Gem::Specification.new do |s|
  s.name        = "woocommerce_api"
  s.version     = WooCommerce::VERSION
  s.date        = "2016-05-09"

  s.summary     = "A Ruby wrapper for the WooCommerce API"
  s.description = "This gem provide a wrapper to deal with the WooCommerce REST API"
  s.license     = "MIT"

  s.authors     = ["Claudio Sanches"]
  s.email       = "claudio@woothemes.com"
  s.files       = Dir["lib/woocommerce_api.rb", "lib/woocommerce_api/*.rb"]
  s.homepage    = "https://github.com/woothemes/wc-api-ruby"

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_runtime_dependency "httparty", "~> 0.13", ">= 0.13.7"
end
