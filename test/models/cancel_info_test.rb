require 'test_helper'

class CancelInfoTest < ActiveSupport::TestCase
  def setup
    grade       = 1
    type_str    = "補講"
    date_str    = "2017年01月23日[1-2時限]"
    altdate_str = "2017年01月10日[7-8時限]"
    classroom   = "81番教室"
    department  = "電子情報工学科"
    teacher     = "高専 太郎"
    note        = "備考"

    @cancel_info = CancelInfo.new(
      grade:       grade,
      type_str:    type_str,
      date_str:    date_str,
      date:        CancelInfo.parse_date_str(date_str),
      altdate_str: altdate_str,
      altdate:     CancelInfo.parse_date_str(altdate_str),
      classroom:   classroom,
      department:  department,
      teacher:     teacher,
      note:        note
    )
  end

  # --- grade ---

  test "grade should be presence" do
    @cancel_info.grade = nil
    assert_not @cancel_info.valid?
  end

  test "grade should be in range 1..5" do
    @cancel_info.grade = 0
    assert_not @cancel_info.valid?
    @cancel_info.grade = 1
    assert @cancel_info.valid?
    @cancel_info.grade = 6
    assert_not @cancel_info.valid?
  end

  # --- type_str ---

  test "type_str should be presence" do
    @cancel_info.type_str = "  "
    assert_not @cancel_info.valid?
  end

  test "type_str with valid data" do
    @cancel_info.type_str = "休講"
    assert @cancel_info.valid?
    @cancel_info.type_str = "補講"
    assert @cancel_info.valid?
  end

  test "type_str with invalid data" do
    @cancel_info.type_str = "休講補講"
    assert_not @cancel_info.valid?
  end

  # --- date_str ---

  test "date_str should be presence" do
    @cancel_info.date_str = "  "
    assert_not @cancel_info.valid?
  end

  # --- date ---

  test "CancelInfo.parse_date_str should parse correctly" do
    date_str = "2017年01月23日[1-2時限]"
    assert_equal(
      Time.zone.local(2017, 1, 23, 8, 50),
      CancelInfo.parse_date_str(date_str)
    )
  end

  # --- altdate_str ---

  test "altdate_str should be presence" do
    @cancel_info.altdate_str = "  "
    assert_not @cancel_info.valid?
  end

  # --- department ---

  test "department should be presence" do
    @cancel_info.department = "  "
    assert_not @cancel_info.valid?
  end

  # --- teacher ---

  test "teacher should be presence" do
    @cancel_info.teacher = "  "
    assert_not @cancel_info.valid?
  end
end
