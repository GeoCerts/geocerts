VCR.config do |c|
  c.stub_with :fakeweb
  c.cassette_library_dir = File.expand_path("../../../test/fixtures/remote", __FILE__)
end
