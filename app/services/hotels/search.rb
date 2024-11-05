module Hotels
  class Search
    def self.call(term: nill)
      return Hotel.order(:name) unless term.present?

      term = term.downcase
      Hotel.where('lower(name) LIKE ?', "%#{term}%").order(:name)

    end
  end
end
