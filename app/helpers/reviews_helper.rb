module ReviewsHelper
	def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = (5 - rating)
    "★" * rating.round + "☆" * remainder
  end

  def time_since_review(review)
    total_period = Time.new - review.created_at
    period_in_hours = total_period/3600
    period_in_days = total_period/3600/24
    display_content(period_in_hours, period_in_days)
  end

  def display_content(hours, days)
    if hours > 48
      days.floor.to_s + ' days ago'
    elsif hours < 48 && hours > 24  
      ' yesterday'
    elsif hours < 1
      ' less than an hour ago'
    elsif hours.round == 1 && hours > 1
      ' just over an hour ago'
    elsif hours < 24 && hours.round > 1
      ' around ' + hours.round.to_s + ' hours ago'
    end
  end

end