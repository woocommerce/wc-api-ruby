# WooCommerce API - Ruby Client

A Ruby wrapper for the WooCommerce REST API. Easily interact with the WooCommerce REST API using this library.

[![build status](https://secure.travis-ci.org/woothemes/wc-api-ruby.svg)](http://travis-ci.org/woothemes/wc-api-ruby)
[![gem version](https://badge.fury.io/rb/woocommerce_api.svg)](https://rubygems.org/gems/woocommerce_api)

## Installation

```
gem install woocommerce_api
```

## Getting started

Generate API credentials (Consumer Key & Consumer Secret) following this instructions <http://docs.woothemes.com/document/woocommerce-rest-api/>
.

Check out the WooCommerce API endpoints and data that can be manipulated in <http://woothemes.github.io/woocommerce-rest-api-docs/>.

## Setup

```ruby
require "woocommerce_api"

woocommerce = WooCommerce::API.new(
  "http://example.com",
  "ck_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
  "cs_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
)
```

### Options

|       Option      |   Type   | Required |               Description                |
| ----------------- | -------- | -------- | ---------------------------------------- |
| `url`             | `String` | yes      | Your Store URL, example: http://woo.dev/ |
| `consumer_key`    | `String` | yes      | Your API consumer key                    |
| `consumer_secret` | `String` | yes      | Your API consumer secret                 |
| `args`            | `Hash`   | no       | Extra arguments (see Args options table) |

#### Args options

|       Option       |   Type   | Required |                                                 Description                                                  |
| ------------------ | -------- | -------- | ------------------------------------------------------------------------------------------------------------ |
| `version`          | `String` | no       | API version, default is `v3`                                                                                 |
| `verify_ssl`       | `Bool`   | no       | Verify SSL when connect, use this option as `false` when need to test with self-signed certificates          |
| `signature_method` | `String` | no       | Signature method used for oAuth requests, works with `HMAC-SHA1` and `HMAC-SHA256`, default is `HMAC-SHA256` |

## Methods

|   Params   |   Type   |                         Description                          |
| ---------- | -------- | ------------------------------------------------------------ |
| `endpoint` | `String` | WooCommerce API endpoint, example: `customers` or `order/12` |
| `data`     | `Hash`   | Only for POST and PUT, data that will be converted to JSON   |
| `query`    | `Hash`   | Only for GET and DELETE, request query string                |

### GET

- `.get(endpoint, query)`

### POST

- `.post(endpoint, data)`

### PUT

- `.put(endpoint, data)`

### DELETE

- `.delete(endpoint, query)`

#### Response

All methods will return [HTTPary::Response](https://github.com/jnunemaker/httparty) object.

```ruby
response = api.get "customers"

puts response.parsed_response # A Hash of the parsed JSON response
# Example: {"customers"=>[{"id"=>8, "created_at"=>"2015-05-06T17:43:51Z", "email"=>

puts response.code # A Interger of the HTTP code response
# Example: 200

puts response.headers["x-wc-total"] # Total of items
# Example: 2

puts response.headers["x-wc-totalpages"] # Total of pages
# Example: 1
```

## Release History

- 2015-08-27 - 1.1.0 - Added `query` argument for GET and DELETE methods, reduced chance of nonce collisions and added support for urls including ports
- 2015-08-27 - 1.0.3 - Encode all % characters in query string for OAuth 1.0a.
- 2015-08-12 - 1.0.2 - Fixed the release date.
- 2015-08-12 - 1.0.1 - Escaped oauth_signature in url query string.
- 2015-07-15 - 1.0.0 - Stable release.
- 2015-07-15 - 0.0.1 - Beta release.
