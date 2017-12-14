NnctClassInfo
==============

[長野高専の補講情報](http://www.nagano-nct.ac.jp/current/cancel_info.php)
のページから休講情報と補講情報を取り出すAPI群を提供しています。

現在のホスト名は、nnct.herokuapp.com です。
heroku なので初めてアクセスするときにレスポンスが返ってくるまで長く待たされる場合があります。


URL
-------

長野高専の補講情報（JSON）

[1年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/1)  
[2年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/2)  
[3年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/3)  
[4年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/4)  
[5年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/5)

[1年の明日の休講・補講情報](https://nnct.herokuapp.com/cancel_info/1/only_tomorrow)  
[2年の明日の休講・補講情報](https://nnct.herokuapp.com/cancel_info/2/only_tomorrow)  
[3年の明日の休講・補講情報](https://nnct.herokuapp.com/cancel_info/3/only_tomorrow)  
[4年の明日の休講・補講情報](https://nnct.herokuapp.com/cancel_info/4/only_tomorrow)  
[5年の明日の休講・補講情報](https://nnct.herokuapp.com/cancel_info/5/only_tomorrow)  


APIs
-----

### GET /cancel_info/{id}
長野高専の`id`年の休講補講情報を取得します。

+ Response 200 (application/json)

    + Attributes (objects of array)
        + grade: (int) -- 学年
        + type_str: 休講 or 補講 (string)
        + date_str: (string) -- 対象となる日付
        + date: (date) -- 対象となる日付の ISO 8601 拡張形式
        + altdate_str: (string) -- 代わりの日付
        + altdate: (date) -- 代わりの日付の ISO 8601 拡張形式
        + subject: (string) -- 科目名
        + department: (string) -- 学科名
        + classroom: n番教室 (string) -- 教室名
        + teacher: (string) -- 担当教員名
        + note: (string, optional) -- 備考

    + Body

            [
                {
                    "grade": 3,
                    "type_str": "休講",
                    "date_str": "2016年04月18日[5-6時限]",
                    "date": "2016-04-18T12:50:00.000+09:00",
                    "altdate_str": "2016年04月19日[3-4時限]",
                    "altdate": "2016-04-19T10:30:00.000+09:00",
                    "subject": "電気回路[３年Ｊ科]",
                    "department": "電子情報工学科",
                    "classroom": "３４番教室",
                    "teacher": "高専　太郎",
                    "note": null
                },
                {
                    "grade": 3,
                    "type_str": "休講",
                    "date_str": "2016年04月22日[1-2時限]",
                    "date": "2016-04-22T08:50:00.000+09:00",
                    "altdate_str": "2016年04月13日[7-8時限]",
                    "altdate": "2016-04-13T14:30:00.000+09:00",
                    "subject": "設計製図II[３年Ｓ科]",
                    "department": "電子制御工学科",
                    "classroom": "製図室１",
                    "teacher": "高専　花子",
                    "note": "教室に掲示します"
                }
            ]


### GET /cancel_info/{id}/only_tomorrow
長野高専の`id`年の「明日の」休講補講情報を取得します。

+ Response 200 (application/json)
    + Attributes (objects of array)
        + GET /cancel_info/{id} と同じ
    + Body
        + GET /cancel_info/{id} と同じ
