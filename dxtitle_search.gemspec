Gem::Specification.new do |s|
  s.name = 'dxtitle_search'
  s.version = '0.2.0'
  s.summary = 'Search title entries from plain text (derived from a Dynarex document).'
  s.authors = ['James Robertson']
  s.files = Dir['lib/dxtitle_search.rb']
  s.add_runtime_dependency('dynarex', '~> 1.8', '>=1.8.19')  
  s.signing_key = '../privatekeys/dxtitle_search.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/dxtitle_search'
end
