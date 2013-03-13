require 'acceptance/acceptance_helper'

feature 'Widget list', %q{
  In order to ...
  As a ...
  I want ...
} do

  scenario 'Does index page for Sequel Example load?' do
    visit '/widget_list_examples/ruby_items/'
    save_and_open_page
    page.should_not have_content("An error occurred")
    page.should_not have_content("Application Trace")
    page.should_not have_content("Currently no data")
    page.should_not have_content("No Ruby Items Found")
  end

end
