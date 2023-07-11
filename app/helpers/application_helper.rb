module ApplicationHelper
  def navigation
    content_tag(:header, class: 'navigation') do
      content_tag(:nav) do
        link_to('Home', root_path) +
          link_to('Login', new_user_session_path)
      end
    end +
      content_tag(:div, class: 'notice alert') do
        content_tag(:p, notice) +
          content_tag(:p, alert)
      end
  end
end
