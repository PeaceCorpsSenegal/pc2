module ApplicationHelper

  # return a title on a per-page basis
  def title
    base_title = 'Peace Corps Senegal'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def organization
    'Peace Corps'
  end

  def country
    'Senegal'
  end

  def avatar_for(object, options = { :size => nil, :photo => 'blank.png' })
    if object.photo.nil?
      options[:size] ||= '100x100'
      options[:photo] ||= 'blank.png'
      link_to image_tag(options[:photo], :size => options[:size]), object
    else
      options[:size] ||= :icon
      link_to image_tag(object.photo.photo.url(options[:size])), object
    end
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(text).html_safe
  end

  def find_named_routes
    routes = []

    Rails.application.routes.named_routes.each do |name, route|
      req = route.requirements
      if req[:controller] == params[:controller] && req[:action] == params[:action]
        routes << name
      end
    end

    routes
  end

  def nested_li(objects)
    output = ""
    output += "<ul>"
    path = [nil]
    objects.each do |o|
      if o.parent_id != path.last
        # we are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # remove wrong wrong tailing paths elements
          while path.last != o.parent_id
            path.pop
            output += "\n</ul>"
          end
        else
          path << o.parent_id
          output += "\n<ul>"
        end
      end
      output += "\n<li>#{yield o}</li>"
    end
    #pop off unfinished paths elements
    while path.length > 1
      path.pop
      output += "\n</ul>"
    end
    output += "\n</ul>"
    return output.html_safe
  end

  def fetch_menu
    Page.unscoped.order('lft ASC')
  end

  def render_photo(id, size)
    image_tag((id.nil?) ? 'blank.png' : Photo.find(id).photo.url(size))
  end

  def photobar_selector
    Photo.limit(20)
  end

end
