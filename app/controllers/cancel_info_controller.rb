require 'open-uri'
require 'nokogiri'

class CancelInfoController < ApplicationController
  using CancelInfoHelper

  # GET /cancel_info/:id
  def show
    grade = params[:id]
    update_cache_if_needed(grade: grade)

    json = JSON.parse( CancelInfo.where(grade: grade).to_json )
    json.map! { |e| e.delete("id"); e } # delete "id" key
    render json: json
  end

  # GET /cancel_info/:id/only_tomorrow
  def show_only_tomorrow
    grade = params[:id]
    update_cache_if_needed(grade: grade)

    json = JSON.parse( CancelInfo.where(grade: grade).to_json )
    json.map! { |item| item.delete("id"); item } # delete "id" key
    json.select! { |item| Time.zone.parse(item["date"]).tomorrow? } # select only tomorrow item
    render json: json
  end

  # --- private methods ---

  private
    # return url refers to given grade canceled class info
    # e.g.
    #   get_url(grade: 1) # => "http://www.nagano-nct.ac.jp/current/cancel_info_1st.php"
    #
    def get_url(hash = {})
      grade = hash[:grade].to_s
      grade_map = {"1" => "1st", "2" => "2nd", "3" => "3rd", "4" => "4th", "5" => "5th"}
      grade_str = grade_map[grade]
      "http://www.nagano-nct.ac.jp/current/cancel_info_#{grade_str}.php"
    end

    # return array of hash which has attributes 'grade', 'subject', 'date', etc...
    # e.g.
    #   get_cancel_info(grade: 1)
    #   # => [
    #          { "grade" => "1",
    #            "type_str" => "補講",
    #            "date_str" => "2017年01月23日[1-2時限]",
    #            :
    #          },
    #          { "grade" => "1",
    #            "type_str" => "休講",
    #            :
    #          }
    #        ]
    #
    def get_cancel_info(hash = {})
      grade = hash[:grade].to_s
      url = get_url(grade: grade)

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

    # Update cache if cache is not found, or cache's timestamp is yesterday
    #
    def update_cache_if_needed(hash = {})
      grade = hash[:grade].to_s
      cache = CancelInfo.find_by(grade: grade)

      if cache.nil? || cache.updated_at.yesterday?
        CancelInfo.where(grade: grade).destroy_all
        json = get_cancel_info(grade: grade)
        json.each do |item|
          CancelInfo.create!(
            grade:       grade,
            type_str:    item['type_str'],
            date_str:    item['date_str'],
            date:        CancelInfo.parse_date_str(item['date_str']),
            altdate_str: item['altdate_str'],
            altdate:     CancelInfo.parse_date_str(item['altdate_str']),
            classroom:   item['classroom'],
            department:  item['department'],
            teacher:     item['teacher'],
            note:        item['note']
          )
        end
      end
    end
end
