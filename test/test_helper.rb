require "minitest/autorun"
require "fakeweb"
require "json"
require "woocommerce_api"

module WoocommerceApi; end

pattern = File.join(__dir__, 'woocommerce_api', '*')
files = Dir[pattern]
files.each { |file| require file }
