class CancelInfo < ApplicationRecord
  validates :type_str, presence: true
  validates :date_str, presence: true
  validates :date, presence: true
  validates :altdate_str, presence: true
  validates :altdate, presence: true
  validates :classroom, presence: true
  validates :department, presence: true
  validates :teacher, presence: true

  # --- class methods ---

  # convert string date_str into TimeWithZone
  # e.g.
  #   2017年01月23日[1-2時限] => Mon, 23 Jan 2017 08:50:00 JST +09:00
  #   2017年01月10日[7-8時限] => Tue, 10 Jan 2017 14:30:00 JST +09:00
  def self.parse_date_str(date_str)
    m = date_str.match(/(\d{4})年(\d{2})月(\d{2})日\[(\d)\-\d時限\]/)
    return nil if m.nil?
    year = m[1]
    year, month, day, period = m[1..4].map(&:to_i)
    hour, minute = self.period_to_hours(period)

    Time.zone.local(year, month, day, hour, minute)
  end

  def self.period_to_hours(period)
    case period
    when 1 then [8, 50]  # 8:50-
    when 3 then [10, 30] # 10:30-
    when 5 then [12, 50] # 12:50-
    when 7 then [14, 30] # 14:30-
    end
  end
end
