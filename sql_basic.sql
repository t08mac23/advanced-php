-- 問1
-- 国名を全て抽出してください。
SELECT `name` FROM `countries`;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT `region` FROM `countries` WHERE `region` LIKE '%Europe%';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT `region` FROM `countries` WHERE `region` NOT LIKE '%Europe%';

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT `population` FROM `countries` WHERE `population` >= 100000;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT `life_expectancy` FROM `countries`
WHERE `life_expectancy` BETWEEN 56 AND 76;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT `name`, `country_code` FROM `cities` WHERE `country_code` = 'NLB'
OR `country_code` = 'ALB' OR `country_code` = 'DZA';

-- 問7
-- 独立記念日がない国をすべて抽出してください。
SELECT `name` FROM `countries` WHERE `indep_year` IS NULL;

-- 問8
-- 独立記念日がある国をすべて抽出してください。
SELECT `name` FROM `countries` WHERE `indep_year`;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT `name` FROM `countries` WHERE `name` LIKE '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT `name` FROM `countries` WHERE `name` LIKE '%st%';


-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT `name` FROM `countries` WHERE `name` LIKE 'an%';


-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT `name` FROM `countries` WHERE `indep_year` < 1990 OR `population` > 100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT * FROM `countries` WHERE `code` = 'DZA'
OR `code` = 'ALB' AND `indep_year` < 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT `region` FROM `countries`;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT `name`, "の人口は", `population`, "人です" FROM `countries`;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT `name`, `life_expectancy` FROM `countries`
WHERE NOT `life_expectancy` IS NULL ORDER BY `life_expectancy` ASC;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT `name`, `life_expectancy` FROM `countries`
WHERE NOT `life_expectancy` IS NULL ORDER BY `life_expectancy` DESC;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT `name`, `life_expectancy`, `indep_year` FROM `countries`
ORDER BY `life_expectancy` DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT SUBSTRING(c.code, 1, 1), c.name FROM countries as c;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT `name`, LENGTH (name)`文字数` FROM `countries` ORDER BY `文字数` DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT `region`, AVG(`life_expectancy`), AVG(`population`)
FROM `countries` GROUP BY `region`;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT `region`, MAX(`life_expectancy`), MAX(`population`)
FROM `countries` GROUP BY `region`;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT `region`, `surface_area` FROM `countries`
WHERE `region` LIKE ('%Asia') ORDER BY `surface_area` ASC LIMIT 1;

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT continent, SUM(surface_area) FROM countries
GROUP BY continent HAVING continent LIKE '%Asia%';

-- 問25
-- 全ての国と言語を表示してください。
SELECT a.name, b.language FROM countries as a
JOIN countrylanguages as b ON a.code = b.country_code;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT a.name, b.language, c.name FROM countries as a
JOIN countrylanguages as b ON a.code = b.country_code
JOIN cities as c ON a.code = c.country_code;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT x.name, x.country_code FROM celebrities as x
LEFT JOIN countries as y ON x.country_code = y.code;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT x.name, y.name, z.language FROM celebrities as x
JOIN countries as y ON x.country_code = y.code
JOIN countrylanguages as z ON x.country_code = z.country_code
WHERE z.is_official LIKE "T";

-- 問29
-- 全ての有名人の名前と国名をテーブル結合せずに出力してください。
SELECT x.name FROM celebrities as x
UNION SELECT y.name FROM countries as y;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT y.name as country_name, MAX(x.age), MIN(x.age) FROM celebrities as x
JOIN countries as y ON x.country_code = y.code
GROUP BY country_code HAVING MIN(x.age) <= 30
AND MAX(x.age) >= 50;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT COUNT(name) FROM celebrities
WHERE birth LIKE '1991%'
UNION ALL
SELECT COUNT(name) FROM celebrities
WHERE birth LIKE '1981%';

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT y.name, x.name as country_name, x.life_expectancy FROM countries as x
JOIN celebrities as y ON x.code = y.country_code
ORDER BY x.life_expectancy DESC;

