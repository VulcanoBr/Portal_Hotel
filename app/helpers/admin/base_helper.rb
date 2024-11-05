module Admin::BaseHelper
  def resource_collection_title
    t "resources.#{controller_path.gsub("/", ".")}.collection"
  end

  def resource_edit_title
    t "resources.#{controller_path.gsub("/", ".")}.edit"
  end

  def resource_new_title
    t "resources.#{controller_path.gsub("/", ".")}.new"
  end

  def resource_form_title
    %w[create new].include?(action_name) ? resource_new_title : resource_edit_title
  end
end
