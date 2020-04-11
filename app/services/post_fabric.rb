module PostFabric
  class Parse
    attr_reader :row_link, :user

    def initialize(row_link, user)
      @row_link = row_link
      @user = user
    end

    def generate_post

      if @row_link.include?('habr.com')
        parse_for_habr(@row_link)
        return 'done'
      else
        return 'error'
      end
    end

    def parse_for_habr(row_link)
      row_post = Nokogiri::HTML(open(row_link).read)
      post_title = row_post.css('.post__title-text').text
      post_first_picture = row_post.search('#post-content-body > img:nth-child(1)').each do |img|
        break img['src']
      end
    end

  end
end