module FlashHelper
  def flash_class(flash_key)
    case flash_key.to_sym
    when :alert
      "bg-error"
    else
      "bg-w"
    end 
  end
end