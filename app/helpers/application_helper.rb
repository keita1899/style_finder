module ApplicationHelper
  def alert_class(key)
    if key == "notice"
      "bg-green-100 text-green-800"
    else
      "bg-red-100 text-red-800"
    end
  end
end
