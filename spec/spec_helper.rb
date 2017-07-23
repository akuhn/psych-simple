require "bundler/setup"
require "psych/simple"

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end
