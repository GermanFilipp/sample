module API
  module JsonHelper
    def generate_pagination(paginated_obj)
      {
        pagination: {
          current_page: paginated_obj.current_page,
          prev_page: paginated_obj.prev_page,
          next_page: paginated_obj.next_page,
          total_pages: paginated_obj.total_pages
        }
      }
    end

    def api_error(messages, code)
      { errors: { code: code, details: Array.wrap(messages) } }
    end
  end
end