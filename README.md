NnctClassInfo (β version)
=========================

[長野高専の補講情報](http://www.nagano-nct.ac.jp/current/cancel_info.php)
のページから休講情報と補講情報を取り出すAPI群を提供しています。

現在のホスト名は、http://nnct.herokuapp.com です。


URL
-------

長野高専の補講情報（JSON）

[1年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/1)  
[2年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/2)  
[3年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/3)  
[4年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/4)  
[5年の休講・補講情報](https://nnct.herokuapp.com/cancel_info/5) 


APIs
-----

### GET /cancel_info/{id}
長野高専の`id`年の補講休講情報を取得します。

+ Response 200 (application/json)

    + Attributes (objects of array)
        + type_str: 休講 or 補講 (string)
        + date_str: 20xx年xx月xx日\[a-b時限] (string) -- 対象となる日付
        + date: 20xx-xx-xxTxx:xx:00.000+09:00 -- 対象となる日付の ISO 8601 拡張形式（moment.jsなどでパース可能）
        + altdate_str: 20xx年xx月xx日\[a-b時限] (string) -- 代わりの日付
        + altdate: 20xx-xx-xxTxx:xx:00.000+09:00 -- 代わりの日付の ISO 8601 拡張形式（moment.jsなどでパース可能）
        + subject: xxxx\[a年b科] (string) -- 科目名
        + department: xxxx工学科 (string) -- 学科名
        + classroom: n番教室 (string) -- 教室名
        + teacher: (string) -- 担当教員名
        + note: (string, optional) -- 備考

    + Body

            [
                {
                    "type": "休講",
                    "date": "2016年04月18日[5-6時限]",
                    "alternative": "2016年04月19日[3-4時限]",
                    "subject": "電気回路[３年Ｊ科]",
                    "department": "電子情報工学科",
                    "class_room": "３４番教室",
                    "teacher": "高専　太郎"
                },
                {
                    "type": "休講",
                    "date": "2016年04月22日[1-2時限]",
                    "alternative": "2016年04月13日[7-8時限]",
                    "subject": "設計製図II[３年Ｓ科]",
                    "department": "電子制御工学科",
                    "class_room": "製図室１",
                    "teacher": "高専　花子",
                    "note": "教室に掲示します"
                }
            ]


 
