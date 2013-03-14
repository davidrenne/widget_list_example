RSpec.configure do |config|
  config.before(:each) do
    if example.metadata[:js]
      Capybara.current_driver = :selenium
    end
  end

  config.after(:each) do
    Capybara.use_default_driver if example.metadata[:js]
  end
end