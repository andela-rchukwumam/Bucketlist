module Api
  class Paginate
    def initialize(limit, page)
      @limit = limit.to_i
      @page = page.to_i
    end

    def limit
      @limit = 20 if @limit < 1
      @limit = 100 if @limit > 100
      @limit
    end

    def offset
      if @page < 2
        0
      elsif @page == 2
        limit
      else
        @page * limit
      end
    end

    def pagination(list)
      list.limit(limit).offset(offset)
    end
  end
end
