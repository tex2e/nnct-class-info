require 'open-uri'
require 'nokogiri'

class CancelInfoController < ApplicationController
  def show
    grade = params[:id]
    cache = CancelInfo.find_by(grade: grade)

    # Update cache if cache is not found, or cache's timestamp is yesterday
    if cache.nil? || yesterday?(cache.updated_at)
      CancelInfo.where(grade: grade).destroy_all
      json = get_cancel_info(grade: grade)
      json.each do |item|
        CancelInfo.create!(
          grade:       grade,
          type_str:    item['type_str'],
          date_str:    item['date_str'],
          date:        CancelInfo.parse_date_str(item['date_str']),
          altdate_str: item['date_str'],
          altdate:     CancelInfo.parse_date_str(item['date_str']),
          classroom:   item['classroom'],
          department:  item['department'],
          teacher:     item['teacher'],
          note:        item['note']
        )
      end
    end

    render json: CancelInfo.where(grade: grade)
  end

  private
    def get_cancel_info(hash = {})
      grade = hash[:grade].to_s
      grade_map = {"1" => "1st", "2" => "2nd", "3" => "3rd", "4" => "4th", "5" => "5th"}
      grade_str = grade_map[grade]
      url = "http://www.nagano-nct.ac.jp/current/cancel_info_#{grade_str}.php"

      nokogiri_nodes = Nokogiri::HTML(open(url)).css('div.main table.cancel')
      nokogiri_nodes.map do |table|
        hash = {"grade" => grade}
        table.css('tr th').each do |node|
          case node.content
          when /(休|補)講日/
            next if hash['type_str'] # next if already set
            hash['type_str'] = node.content.chop
            hash['date_str'] = node.next.content
            hash['altdate_str'] = node.next.next.next.content
          when '科目名'
            hash['subject'] = node.next.content
          when '教室'
            hash['classroom'] = node.next.content
          when '学科'
            hash['department'] = node.next.content
          when '教員'
            hash['teacher'] = node.next.content
          when '備考'
            hash['note'] = node.next.content
          end
        end
        hash
      end
    end

    def yesterday?(datetime)
      from = (Time.zone.now - 1.day).beginning_of_day
      to   = (Time.zone.now).beginning_of_day
      Time.zone.now.between?(from, to)
    end
end
