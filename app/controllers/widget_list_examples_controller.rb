class WidgetListExamplesController < ApplicationController
  def ruby_items
    #
    # Load Sample "items" Data. Comment out in your first time executing a widgetlist to create the items table
    # 
    
=begin
WidgetList::List.get_database.create_table :items do
  primary_key :id
  String :name
  Float :price
  Int :sku
  Date :date_added
end
items = WidgetList::List.get_database[:items]
100.times {
  items.insert(:name => 'abc', :price => rand * 100, :date_added => '2008-02-01', :sku => 12345)
  items.insert(:name => '123', :price => rand * 100, :date_added => '2008-02-02', :sku => 54321)
  items.insert(:name => 'asdf', :price => rand * 100, :date_added => '2008-02-03', :sku => 67895)
  items.insert(:name => 'qwerty', :price => rand * 100, :date_added => '2008-02-04', :sku => 66666)
  items.insert(:name => 'poop', :price => rand * 100, :date_added => '2008-02-05', :sku => 77777)
} 
=end
    #
    # Setup your first widget_list
    #

    button_column_name = 'actions'
    list_parms   = {}

    #
    # action_buttons will add buttons to the bottom of the list.
    #

    action_buttons =  WidgetList::Widgets::widget_button('Add New Item', {'page' => '/add/'} ) + WidgetList::Widgets::widget_button('Do something else', {'page' => '/else/'} )

    #
    # Give it a name, some SQL to feed widget_list and set a noDataMessage
    #
    list_parms['name']          = 'ruby_items_yum'
    list_parms['searchIdCol']   = ['id','sku']
    list_parms['view']          = '(SELECT \'\'  as checkbox,a.* FROM items a ) a'
    list_parms['noDataMessage'] = 'No Ruby Items Found'
    list_parms['title']         = 'Ruby Items!!!'

    #
    # Create small button array and pass to the buttons key
    #

    mini_buttons = {}
    mini_buttons['button_edit'] = {'page'       => '/edit',
                                   'text'       => 'Edit',
                                   'function'   => 'Redirect',
                                     #pass tags to pull from each column when building the URL
                                   'tags'       => {'my_key_name' => 'name','value_from_database'=>'price'}}

    mini_buttons['button_delete'] = {'page'       => '/delete',
                                     'text'       => 'Delete',
                                     'function'   => 'alert',
                                     'innerClass' => 'danger'}
    list_parms['buttons']                                            = {button_column_name => mini_buttons}
    list_parms['fieldFunction']                                      = {
                                                                          button_column_name => "''",
                                                                          'date_added'  => ['postgres','oracle'].include?(WidgetList::List.get_database.db_type) ? "TO_CHAR(date_added, 'MM/DD/YYYY')" : "date_added"
                                                                       }
    list_parms['groupByItems']    = ['All Records','Item Name']

    #
    # Generate a template for the DOWN ARROW for CUSTOM FILTER
    #

    template = {}
    input = {}

    input['id']          = 'comments'
    input['name']        = 'comments'
    input['width']       = '170'
    input['max_length']  = '500'
    input['input_class'] = 'info-input'
    input['title']       = 'Optional CSV list'

    button_search = {}
    button_search['innerClass']   = "success btn-submit"
    button_search['onclick']      = "alert('This would search, but is not coded.  That is for you to do')"

    list_parms['list_search_form'] = WidgetList::Utils::fill( {
                              '<!--COMMENTS-->'            => WidgetList::Widgets::widget_input(input),
                              '<!--BUTTON_SEARCH-->'       => WidgetList::Widgets::widget_button('Search', button_search),
                              '<!--BUTTON_CLOSE-->'        => "HideAdvancedSearch(this)" } ,
    '
    <div id="advanced-search-container">
    <div class="widget-search-drilldown-close" onclick="<!--BUTTON_CLOSE-->">X</div>
      <ul class="advanced-search-container-inline" id="search_columns">
        <li>
           <div>Search Comments</div>
           <!--COMMENTS-->
        </li>
      </ul>
    <br/>
    <div style="text-align:right;width:100%;height:30px;" class="advanced-search-container-buttons"><!--BUTTON_RESET--><!--BUTTON_SEARCH--></div>
    </div>')

    #
    # Map out the visible fields
    #

    list_parms.deep_merge!({'fields' =>
                    {
                      'checkbox'=> 'checkbox_header',
                    }
                 })
                 
    list_parms.deep_merge!({'fields' =>
                    {
                      'id'=> 'Item Id',
                    }
                 })
                 
    list_parms.deep_merge!({'fields' =>
                    {
                      'name'=> 'Name',
                    }
                 })
                 
    list_parms.deep_merge!({'fields' =>
                    {
                      'price'=> 'Price of Item',
                    }
                 })
                 
                 
    list_parms.deep_merge!({'fields' =>
                    {
                      'sku'=> 'Sku #',
                    }
                 })
		 
                 
    list_parms.deep_merge!({'fields' =>
                    {
                      'date_added'=> 'Date Added',
                    }
                 })
		 
    list_parms.deep_merge!({'fields' =>
                    {
                      button_column_name => button_column_name.capitalize,
                    }
                 })
                 
    #
    # Setup a custom field for checkboxes stored into the session and reloaded when refresh occurs
    #

    list_parms.deep_merge!({'inputs' =>
                          {'checkbox'=>
                             {'type' => 'checkbox'
                             }
                          }
                       })

    list_parms.deep_merge!({'inputs' =>
                          {'checkbox'=>
                             {'items' =>
                               {
                                 'name'          => 'visible_checks[]',
                                 'value'         => 'id', #the value should be a column name mapping
                                 'class_handle'  => 'info_tables',
                               }
                             }
                          }
                       })

    list_parms.deep_merge!({'inputs' =>
                          {'checkbox_header'=>
                             {'type' => 'checkbox'
                             }
                          }
                       })

    list_parms.deep_merge!({'inputs' =>
                          {'checkbox_header'=>
                             {'items' =>
                               {
                                 'check_all'     => true,
                                 'id'            => 'info_tables_check_all',
                                 'class_handle'  => 'info_tables',
                               }
                             }
                          }
                       })

    list = WidgetList::List.new(list_parms)

    #
    # If AJAX, send back JSON
    #
    if $_REQUEST.key?('BUTTON_VALUE') && $_REQUEST['LIST_NAME'] == list_parms['name']
      ret = {}
      ret['list']     = WidgetList::Utils::fill({ '<!--CUSTOM_CONTENT-->' =>  action_buttons } , list.render() )
      ret['list_id']  = list_parms['name']
      ret['callback'] = 'ListSearchAheadResponse'
      return render :inline => WidgetList::Utils::json_encode(ret)
    else
      #
      # Else assign to variable for view
      #
      @output =  WidgetList::Utils::fill({ '<!--CUSTOM_CONTENT-->' =>  action_buttons } , list.render() )
    end
    
  end
end
