module PostFabric
  class Parse
    attr_reader :row_link, :user

    def initialize(row_link, user)
      @row_link = row_link
      @user = user
    end

    def generate_post
      if @row_link.include?('habr.com')
        parse_for_habr(@row_link, @user)
      elsif @row_link.include?('www.bbc.com')
        parse_for_bbc(@row_link, @user)
      elsif @row_link.include?('pikabu.ru')
        parse_for_picabu(@row_link, @user)
      else
        'error'
      end
    end

    def parse_for_habr(row_link, user)
      row_post = Nokogiri::HTML(open(row_link).read)
      post_title = row_post.css('.post__title-text').text
      post_body = row_post.css('#post-content-body').text.gsub("\r\n", ' ')
      post_first_picture = row_post.search('#post-content-body > img:nth-child(1)').each do |img|
        break img['src']
      end

      category_title = row_post.css('#post_496670 > div.post__wrapper > ul.post__hubs.post__hubs_full-post.inline-list > li > a').text
      save_post(category_title, post_title, post_body, post_first_picture, user)
    end

    def parse_for_bbc(row_link, user)
      row_post = Nokogiri::HTML(open(row_link).read)
      post_title = row_post.css('#page > div:nth-child(1) > div.container > div.column--single-column-layout > div.story-body > h1').text
      post_body = row_post.css('#page > div:nth-child(1) > div.container > div.column--single-column-layout > div.story-body > div.story-body__inner').text.gsub("\r\n", ' ')
      post_first_picture = row_post.search('#page > div:nth-child(1) > div.container > div.column--single-column-layout > div.story-body > div.story-body__inner > figure.media-landscape.has-caption.full-width.lead > span > img').each do |img|
        break img['src']
      end

      category_title = row_post.css('.tags-list__tags').text
      save_post(category_title, post_title, post_body, post_first_picture, user)
    end

    def parse_for_picabu(row_link, user)
      row_post = Nokogiri::HTML(open(row_link).read)
      post_title = row_post.css('body > div.app > div > div.main > main > div.page-story > div.page-story__story > article > div.story__main > header > h1 > span').text
      post_body = row_post.css('body > div.app > div > div.main > main > div.page-story > div.page-story__story > article > div.story__main > div.story__content.story__typography > div').text.gsub("\r\n", ' ')
      post_first_picture = row_post.search('body > div.app > div > div.main > main > div.page-story > div.page-story__story > article > div.story__main > div.story__content.story__typography > div > div:nth-child(1) > figure > div > a > img').each do |img|
        break img['src']
      end

      category_title = row_post.css('body > div.app > div > div.main > main > div.page-story > div.page-story__story > article > div.story__main > div.story__tags.tags').text
      save_post(category_title, post_title, post_body, post_first_picture, user)
    end

    def save_post(category_title, post_title, post_body, post_first_picture, user)
      category = Category.create(title: category_title)
      post = Post.new(title: post_title, body: post_body, remote_picture_url: post_first_picture, user_id: user.id, category_id: category.id)
      if post.save
        'Success'
      else
        'Error'
      end
    end
  end
end
