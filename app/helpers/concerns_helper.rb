module ConcernsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_concerns_path
    elsif action_name == 'edit'
      concern_path
    end
  end
end
