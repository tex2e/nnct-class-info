class CreateCancelInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :cancel_infos do |t|
      t.integer :grade       # 4
      t.string :type_str     # "休講" or "補講"
      t.string :date_str     # "2017年01月23日[1-2時限]"
      t.datetime :date       # Mon, 23 Jan 2017 08:50:00 JST +09:00
      t.string :altdate_str  # "2017年01月10日[7-8時限]"
      t.datetime :altdate    # Tue, 10 Jan 2017 14:30:00 JST +09:00
      t.string :subject
      t.string :classroom    # "81番教室"
      t.string :department   # "電子情報工学科"
      t.string :teacher      # "高専　太郎"
      t.string :note         # "補足（空白の場合もある）"

      t.timestamps
    end
  end
end
