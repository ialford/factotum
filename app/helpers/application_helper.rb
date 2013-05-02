module ApplicationHelper

  def input_list(input_label_array)
    contents = "".html_safe
    input_label_array.each do |input, label_text, label_options|
      label_options ||= {}
      contents += content_tag(:li, content_tag(:label, input + " " + content_tag(:span, label_text), label_options))
    end
    content_tag(:ul, contents, :class => "inputs-list")
  end

  def help_popover(title, content, klass = "popover_help")
    link_to(image_tag("help.png"), "#", "data-original-title" => title, "data-content" => content, :class => klass)
  end

  def text_with_help(title, content)
    raw(title) + help_popover(title, content)
  end

  def development_only(&block)
    if Rails.env == 'development'
      render :partial => 'shared/development_only', :locals => {:contents => capture(&block) }
    end
  end

  def success
    flash[:success]
  end

  def error
    flash[:error]
  end

  def display_notices
    content = raw("")
    if notice
      content += content_tag(:div, notice, class: "alert alert-info")
    end
    if alert
      content += content_tag(:div, alert, class: "alert")
    end
    if success
      content += content_tag(:div, success, class: "alert alert-success")
    end
    if error
      content += content_tag(:div, error, class: "alert alert-error")
    end
    content_tag(:div, content, id: "notices")
  end

  def content_title(title)
    content_for(:content_title, content_tag(:h1, title))
  end

  def content_title_links(*links)
    content_for(:content_title_links, raw(links.join(" ")))
  end

  def breadcrumb(*crumbs)
    crumbs.unshift(homepage_link)
    content_for(:breadcrumb, raw(crumbs.join(" &gt; ")))
  end

  def homepage_link
    @homepage_link || link_to("Hesburgh Libraries", "https://www.library.nd.edu")
  end

  def set_homepage_link(link)
    @homepage_link = link
  end
end
