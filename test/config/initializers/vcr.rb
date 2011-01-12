VCR.config do |c|
  c.stub_with :fakeweb
  c.cassette_library_dir = File.expand_path("../../../fixtures/remote", __FILE__)
  c.default_cassette_options = {:record => :none}
  c.before_record do |i|
    i.uri.sub!(GeoCerts.partner_id, '%{PARTNER_ID}')
    i.uri.sub!(GeoCerts.api_token, '%{API_TOKEN}')
    i.request.headers.delete("authorization")
  end
  c.before_playback do |i|
    i.uri.sub!('%{PARTNER_ID}', GeoCerts.partner_id)
    i.uri.sub!('%{API_TOKEN}', GeoCerts.api_token)
  end
end
