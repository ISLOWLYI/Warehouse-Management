module ApplicationHelper
  def nav_link_to(text, path, options = {})
    base_classes = "px-3 py-2 rounded-md text-sm font-medium transition"
    active_classes = "bg-blue-700 text-white"
    inactive_classes = "text-blue-100 hover:bg-blue-600 hover:text-white"

    is_active = current_page?(path)
    classes = "#{base_classes} #{is_active ? active_classes : inactive_classes}"

    link_to text, path, options.merge(class: classes)
  end
end
