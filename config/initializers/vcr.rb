if Rails.env.test?
  require 'vcr'

  VCR.configure do |c|
    c.cassette_library_dir = 'vcr_cassettes'
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
    c.default_cassette_options = { :match_requests_on => [:path] }
  end
end