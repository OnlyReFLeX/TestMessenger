module ApplicationHelper
  def last_seen_at_or_online(last_seen_at)
    last_seen_at = last_seen_at.in_time_zone('Moscow')
    if last_seen_at < 15.minutes.ago
      "Был в сети: #{last_seen_at.try(:strftime, "%d.%m.%Y %H:%M")}"
    else
      "Online"
    end
  end
end
