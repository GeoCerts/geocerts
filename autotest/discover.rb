Autotest.add_hook :initialize do |at|
  at.clear_mappings
  
  %W( coverage rdoc .git .svn pkg ).each do |exception|
    at.add_exception(exception)
  end
  
  at.add_mapping(%r%\Alib/geo_certs\.rb\Z%) { |filename, match|
    at.files_matching %r%test/(units|integrations)/geo_certs_test\.rb\Z%
  }
  
  at.add_mapping(%r%\Alib/geo_certs/(.*)\.rb\Z%) { |filename, match|
    at.files_matching %r%test/(units|integrations)/#{match[1]}_test\.rb\Z%
  }
  
  at.add_mapping(%r%\Atest/.*_test\.rb\Z%) { |filename, match|
    filename
  }
  
  ##
  # force a re-run of all tests for any of the following:
  # 
  at.add_mapping(%r%\Atest/factories\.rb\Z%) { |filename, match|
    at.files_matching %r%\Atest/(units|integrations)/.*_test\.rb\Z%
  }
  
  at.add_mapping(%r%\Atest/test_helper\.rb\Z%) { |filename, match|
    at.files_matching %r%\Atest/(units|integrations)/.*_test\.rb\Z%
  }
  
  at.add_mapping(%r%\Atest/fixtures/.*%) { |filename, match|
    at.files_matching %r%\Atest/(units|integrations)/.*_test\.rb\Z%
  }
  
  at.add_mapping(%r%\Atest/config/.*\.(yml|rb)\Z%) { |filename, match|
    at.files_matching %r%\Atest/(units|integrations)/.*_test\.rb\Z%
  }
  
end