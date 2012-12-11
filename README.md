# Gobble

Gobble is a fake web service handler for integration testing.

You need Gobble if you have a site that makes calls to web services with a client that you can't mock or stub out, eg. something that isn't able to be tested with Rack::Test.

(Gobble currently sees use with Cucumber and Capybara, testing a legacy PHP app.)


## Installation

Add this line to your application's Gemfile:

    gem 'gobble'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gobble


## Usage

TODO: Needs fleshing out.

```
service = Gobble::Remote.new 'http://localhost:9999'
service.respond_to 'GET', '/products', :with => {
  :content_type => :json
  :status => 200,
  :body => [
    {:id => 1, :title => "Big Shoe"},
    {:id => 2, :title => "Little Shoe"}
  ].to_json
}
```

```
service  = Gobble::Remote.new 'http://orders.10.0.0.95.xip.io:9999'
response = service.create_response(
  :content_type => :json
  :status => 200
)

service.respond_to 'GET',  '/orders',   :with => response.with(:body => '[]')
service.respond_to 'POST', '/orders',   :with => response.with(:body => '{"id": 1}')
service.respond_to 'GET',  '/orders/2', :with => response.with(:status => 404)
```


## Licence

Copyright (C) 2012 Rob Howard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
