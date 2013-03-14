module HelperMethods
  #def wait_for_ajax
  #  wait_until(15) do
  #    page.evaluate_script('$.active') == 0
  #  end
  #end
  
  def check_for_common_errors
    page.should_not have_content("An error occurred")
    page.should_not have_content("Application Trace")
    page.should_not have_content("Currently no data")
    page.should_not have_content("No Ruby Items Found")
    page.should_not have_content("Ruby Exception")
  end
  
  def back
    page.evaluate_script('window.history.back()')
  end
  
  def check_count(count)
    page.should have_content("Total " + count.to_s + " records found")
  end
  
  def sort_click(columns=[])
    columns.each {|col|
      #ascending
      find('#' + col+ ' span').click
      sleep(5)
      check_for_common_errors 
      check_count(500)
      
      #descending
      find('#' + col+ ' span').click
      sleep(5)
      check_for_common_errors 
      check_count(500)
    }
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance