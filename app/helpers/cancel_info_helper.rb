module CancelInfoHelper
  refine ActiveSupport::TimeWithZone do
    def yesterday?
      from = (Time.zone.now - 1.day).beginning_of_day
      to   = (Time.zone.now        ).beginning_of_day
      self.between?(from, to)
    end

    def tomorrow?
      from = (Time.zone.now + 1.day).beginning_of_day
      to   = (Time.zone.now + 2.day).beginning_of_day
      self.between?(from, to)
    end
  end
end
