module Cell
  # These ControllerMethods are automatically added to all Controllers when
  # the cells plugin is loaded.
  module ControllerMethods

    # Equivalent to ActionController#render_to_string, except with Cells
    # rather than regular templates.
    def render_cell_to_string(name, state, opts={})
      cell = Base.create_cell_for(self, name, opts)
      
      return cell.render_state(state)
    end
    
    # Expires the cached cell state view, similar to ActionController::expire_fragment.
    # Usually, this method is used in Sweepers.
    # Beside the obvious first two args <tt>cell_name</tt> and <tt>state</tt> you can pass
    # in additional cache key <tt>args</tt> and cache store specific <tt>opts</tt>.
    # 
    # Example:
    #
    #  class ListSweeper < ActionController::Caching::Sweeper
    #   observe List, Item
    #
    #   def after_save(record)
    #     expire_cell_state :my_listing, :display_list
    #   end
    #
    # will expire the view for state <tt>:display_list</tt> in the cell <tt>MyListingCell</tt>.
    def expire_cell_state(cell_name, state, args={}, opts=nil)
      key = Cell::Base.cache_key_for(cell_name, state, args)
      Cell::Base.expire_cache_key(key, opts)
    end
  end
end



