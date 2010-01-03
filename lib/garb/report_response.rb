module Garb  
  class ReportResponse
    # include Enumerable

    def initialize(response_body)
      @xml = response_body
    end
    
    def parse      
      entries = Entry.parse(@xml)
      
      @results = entries.collect do |entry|
        hash = {}
        
        entry.metrics.each do |m|
          name = m.name.sub(/^ga\:/,'').underscore
          hash.merge!({name => m.value})
        end
        
        entry.dimensions.each do |d|
          name = d.name.sub(/^ga\:/,'').underscore
          hash.merge!({name => d.value})
        end
        
        OpenStruct.new(hash)
      end
    end

    def results
      @results || parse
    end
    
    def parse_header
      feed = Feed.parse(@xml)
      @totalResults = feed.totalResults
    end
    
    def total_results
      @total_results || parse_header
    end
    
    class Feed
      include HappyMapper
      
      tag 'feed'
      # namespace "openSearch"
      element :totalResults, String, :tag => 'totalResults', :namespace => 'http://a9.com/-/spec/opensearchrss/1.0/'
    end

    
    class Metric
      include HappyMapper

      tag 'metric'
      namespace 'http://schemas.google.com/analytics/2009'

      attribute :name, String
      attribute :value, String
    end
  
    class Dimension
      include HappyMapper

      tag 'dimension'
      namespace 'http://schemas.google.com/analytics/2009'

      attribute :name, String
      attribute :value, String
    end
  
    class Entry
      include HappyMapper
    
      tag 'entry'

      has_many :metrics, Metric
      has_many :dimensions, Dimension
    end
  end
end