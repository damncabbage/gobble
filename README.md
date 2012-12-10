# Cram

Cram is a fake web service handler for integration testing.

You need Cram if you have a site that makes calls to web services with a client that you can't mock or stub out, eg. something that isn't able to be tested with Rack::Test.

(Cram currently sees use with Cucumber and Capybara, testing a legacy PHP app.)



