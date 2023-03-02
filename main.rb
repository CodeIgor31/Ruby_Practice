# frozen_string_literal: true

require 'date'
# Case
class Chain
  def initialize(periods, start)
    @periods = periods
    @start_date = start
    @diff_day, @diff_month, = @start_date.split('.').map(&:to_i)
  end

  # Проверка на корректность
  def valid?
    diff_day, diff_month, = @start_date.split('.').map(&:to_i)
    @periods.each do |period|
      if period.match(/D/)
        @start_date == get_daily(period)[0] ? (@start_date = get_daily(period)[1]) : (return false)
        diff_day, diff_month, = @start_date.split('.').map(&:to_i)
      elsif period.match(/M/)
        @start_date == get_monthly(period, diff_day)[0] ? (@start_date = get_monthly(period, diff_day)[1]) : (return false)
        diff_month = @start_date.split('.').map(&:to_i)[1]
      else
        @start_date == get_annually(period, diff_month, diff_day)[0] ? (@start_date = get_annually(period, diff_month, diff_day)[1]) : (return false)
      end
    end
    true
  end

  def add(new_period)
    last = @periods[-1]
    case new_period
    when 'annually'
      @periods.push(check_date_type(last).to_s)
    when 'monthly'
      month, year = check_date_type(last)
      @periods.push("#{year}M#{month}")
    when 'daily'
      day, month, year = check_date_type(last)
      @periods.push("#{year}M#{month}D#{day}")
    end
  end

  def get_periods
    @periods
  end

  private

  def check_date_type(period)
    if period.match(/D/)
      get_daily(period)[1].split('.').map(&:to_i)
    elsif period.match(/M/)
      get_monthly(period, @diff_day)[1].split('.')[1..2].map(&:to_i)
    else
      get_annually(period, @diff_month, @diff_day)[1].split('.')[2]
    end
  end

  # Вычисление интервала daily
  def get_daily(daily)
    year, month, day = daily.gsub(/[MD]/, '.').split('.').map(&:to_i)
    date_left = Date.new(year, month, day)
    date_right = date_left + 1
    date_left = date_left.strftime('%d.%m.%Y')
    date_right = date_right.strftime('%d.%m.%Y')
    [date_left, date_right]
  end

  # Вычисление интервала monthly
  def get_monthly(monthly, diff_day)
    year, month = monthly.gsub(/M/, '.').split('.').map(&:to_i)
    day = (diff_day - Date.new(year, month, -1).day).positive? ? Date.new(year, month, -1).day : diff_day
    date_left = Date.new(year, month, day)
    right_day =  (diff_day - Date.new(year, month + 1, -1).day).positive? ? Date.new(year, month + 1, -1).day : diff_day
    date_right = Date.new(year, month + 1, right_day)
    date_left = date_left.strftime('%d.%m.%Y')
    date_right = date_right.strftime('%d.%m.%Y')
    [date_left, date_right]
  end
  
  # Вычисление интервала annually
  def get_annually(annually, diff_month, diff_day)
    year = annually.to_i
    day = (diff_day - Date.new(year, diff_month, -1).day).positive? ? Date.new(year, diff_month, -1).day : diff_day
    date_left = Date.new(year, diff_month, day)
    date_left = date_left.strftime('%d.%m.%Y')
    day = (diff_day - Date.new(year + 1, diff_month, -1).day).positive? ? Date.new(year + 1, diff_month, -1).day : diff_day
    date_right = Date.new(year + 1, diff_month, day).strftime('%d.%m.%Y')
    [date_left, date_right]
  end
end
