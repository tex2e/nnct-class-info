class CancelInfo < ApplicationRecord
  validates :grade, presence: true, inclusion: { in: 1..5 }
  validates :type_str, presence: true, inclusion: { in: %w(休講 補講) }
  validates :date_str, presence: true
  validates :date, presence: true
  validates :altdate_str, presence: true
  validates :altdate, presence: true
  validates :classroom, presence: true
  validates :department, presence: true
  validates :teacher, presence: true

  # --- class methods ---

  class << self
    # convert string date_str into TimeWithZone
    # e.g.
    #   parse_date_str("2017年01月23日[1-2時限]") # => Mon, 23 Jan 2017 08:50:00 JST +09:00
    #   parse_date_str("2017年01月10日[7-8時限]") # => Tue, 10 Jan 2017 14:30:00 JST +09:00
    #
    def parse_date_str(date_str)
      m = date_str.match(/(\d{4})年(\d{2})月(\d{2})日\[(\d)\-\d時限\]/)
      return nil if m.nil?
      year = m[1]
      year, month, day, period = m[1..4].map(&:to_i)
      hour, minute = self.period(period)

      Time.zone.local(year, month, day, hour, minute)
    end

    # return array of array which has a pair of hour and minute
    def periods
      # [[hour, minute]]
      [ [8, 50], [9, 40], [10, 30], [11, 20], [12, 50], [13, 40], [14, 30], [15, 20] ]
    end

    # return a pair of hour and minute which represent start time of given n period
    def period(n)
      self.periods[n - 1]
    end
  end

  # --- instance methods ---

  #
end
