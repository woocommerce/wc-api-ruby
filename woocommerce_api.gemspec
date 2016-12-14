# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rubygems"
require "woocommerce_api/version"


Gem::Specification.new do |s|
  s.name        = "woocommerce_api"
  s.version     = WooCommerce::VERSION
  s.date        = "2016-12-14"

  s.summary     = "A Ruby wrapper for the WooCommerce API"
  s.description = "This gem provide a wrapper to deal with the WooCommerce REST API"
  s.license     = "MIT"

  s.authors     = ["Claudio Sanches"]
  s.email       = "claudio@automattic.com"
  s.files       = Dir["lib/woocommerce_api.rb", "lib/woocommerce_api/*.rb"]
  s.homepage    = "https://github.com/woocommerce/wc-api-ruby"

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_runtime_dependency "httparty", "~> 0.14", ">= 0.14.0"
  s.add_runtime_dependency "json", "~> 2.0", ">= 2.0.0"
end
