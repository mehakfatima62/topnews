module Hackernews
  class Client
    def initialize
      @host = 'community-hacker-news-v1.p.rapidapi.com'
      @key = 'faf2ffda21mshc9b4d020d3eef63p17dee9jsn1537c2af6a79'
    end

    def item(id)
      get("item/#{id}")
    end

    # def topstories
    #   get('topstories')
    # end

    def topstories(start = 0, per_page = 10, expand = true)
      stories = get('topstories')[start...start + per_page]
      if expand
        stories.map! do |story|
          item(story)
        end
      end
      stories
    end

    private
    
    def get(path)
      response = Excon.get(
        'https://' + @host + '/' + path + '.json?print=pretty',
        headers: {
          'x-rapidapi-host' => @host,
          'x-rapidapi-key' => @key,
        }
      )
      return false if response.status != 200
      JSON.parse(response.body)
    end
  end
end
