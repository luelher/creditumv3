module ApplicationHelper

  def flash_messages
    html = ""
    flash.each do |key, value|
      html << content_tag(:div, 
        raw("<p class=\"bg-#{key}\">" + value + "</p>"),
        :class => "box-content")
    end
    
    html.html_safe
  end

end
