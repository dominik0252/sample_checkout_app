module ApplicationHelper
  def app_title
    "Sample Checkout App"
  end

  def full_title(page_title='')
    page_title.empty? ? app_title : page_title + " | " + app_title
  end
end
