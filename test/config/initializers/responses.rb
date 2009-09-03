Dir[File.dirname(__FILE__) + '/../../fixtures/**/*.rb'].sort.each do |response|
  require response
end
