require 'acceptance/acceptance_helper'

feature 'Widget list', '' do
  scenario 'Does index page for Sequel Example load?' do
    visit '/widget_list_examples/ruby_items/'
    #save_and_open_page
    check_for_common_errors
    check_count(500)
  end

  scenario 'Sorting Checks', :js => true do
    visit '/widget_list_examples/ruby_items/'
    check_for_common_errors
    sort_click(['name_linked','id','price','sku_linked','date_added','active'])
  end

=begin
  scenario 'Paging and Limits', :js => true do
    visit '/widget_list_examples/ruby_items/'
    check_for_common_errors
    find('#ruby_items_yum_next').click
    sleep(5)
    check_for_common_errors
  end
=end

  scenario 'Search', :js => true do
    visit '/widget_list_examples/ruby_items/'
    check_for_common_errors
    fill_in 'list_search_id_ruby_items_yum', :with => 'qwerty_1'
    sleep(5)
    check_for_common_errors
    check_count(29)
  end 

  scenario 'Group By Item Name', :js => true do
    visit '/widget_list_examples/ruby_items/'
    check_for_common_errors 
    find('.ruby_items_yum-group .widget-search-arrow').click
    find('#ruby_items_yum_row_2').click
    sleep(5)
    check_for_common_errors
    check_count(167)
    sort_click(['name_linked','cnt'])
  end 

  scenario 'Group By Sku', :js => true do
    visit '/widget_list_examples/ruby_items/'
    check_for_common_errors 
    find('.ruby_items_yum-group .widget-search-arrow').click
    find('#ruby_items_yum_row_3').click
    sleep(5)
    check_for_common_errors
    check_count(493)
    sort_click(['sku_linked','cnt'])
  end 

end
