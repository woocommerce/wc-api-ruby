class WoocommerceApi::SignatureTest < Minitest::Test
  def test_invalid_signature_method
    assert_raises WooCommerce::OAuth::InvalidSignatureMethodError do 
      client = WooCommerce::API.new("http://dev.test/", "user", "pass", signature_method: 'GARBAGE')
      client.get 'products'
    end
  end
end
