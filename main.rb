# frozen_string_literal: true

require 'date'

# Case
module Case
  # Вроде готово
  def self.get_daily(daily)
    str = daily.gsub(/[MD]/, '-')
    year, month, day = str.split('-').map(&:to_i)
    date_left = Date.new(year, month, day)
    date_right = date_left + 1
    date_left = date_left.strftime('%d.%m.%Y')
    date_right = date_right.strftime('%d.%m.%Y')
    [date_left, date_right]
    [date_left, date_right]
  end

  def self.get_monthly(monthly, diff_day)
    str = monthly.gsub(/M/, '-')
    year, month = str.split('-').map(&:to_i)
    day = (diff_day - Date.new(year, month, -1).day).positive? ? Date.new(year, month, -1).day : diff_day
    date_left = Date.new(year, month, day)
    date_right = Date.new(year, month + 1,
                          (diff_day - Date.new(year, month + 1, -1).day).positive? ? Date.new(year, month + 1, -1).day : diff_day)
    date_left = date_left.strftime('%d.%m.%Y')
    date_right = date_right.strftime('%d.%m.%Y')
    [date_left, date_right]
  end

  def self.get_annually(annually, diff_month, diff_day)
    year = annually.to_i
    day = (diff_day - Date.new(year, diff_month, -1).day).positive? ? Date.new(year, diff_month, -1).day : diff_day
    date_left = Date.new(year, diff_month, day)
    date_left = date_left.strftime('%d.%m.%Y')
    day = if (diff_day - Date.new(year + 1, diff_month,
                                  -1).day).positive?
            Date.new(year + 1, diff_month, -1).day
          else
            diff_day
          end
    date_right = Date.new(year + 1, diff_month, day).strftime('%d.%m.%Y')
    [date_left, date_right]
  end

  def self.check(start_date, periods)
    curr_date = start_date
    diff_day, diff_month, diff_year = curr_date.split('.').map(&:to_i)
    periods.each do |period|
      if period.count('D') == 1
        curr_date == get_daily(period)[0] ? (curr_date = get_daily(period)[1]) : (return false)
        diff_day, diff_month, diff_year = curr_date.split('.').map(&:to_i)
      elsif period.count('M') == 1
        curr_date == get_monthly(period, diff_day)[0] ? (curr_date = get_monthly(period, diff_day)[1]) : (return false)
        diff_month = curr_date.split('.').map(&:to_i)[1]
      elsif curr_date == get_annually(period, diff_month,
                                      diff_day)[0]
        (curr_date = get_annually(period, diff_month,
                                  diff_day)[1])
      else
        (return false)
      end
    end
    true
  end
end
