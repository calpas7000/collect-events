module EventsHelper
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
  
  def platform(event)
    if event.pc == true
      puts "pc"
    end
    if event.ps4 == true
      puts "ps4"
    end
    if event.ps5 == true
      puts "ps5"
    end
    if event.xbox_one == true
      puts "xbox_one"
    end
    if event.xbox_series_xs == true
      puts "xbox_series_xs"
    end
    if event.switch == true
      printf "switch"
    end
    if event.smartphone == true
      puts "smartphone"
    end
    if event.other == true
      printf "other"
    end
  end
end
