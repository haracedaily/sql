--------문제
-- 1) 모든 식당 리스트 조회
SELECT * FROM store;
-- 2) 가게별 가게명, 카테고리, 재료 목록, 재료 가격 조회
SELECT store_name, store_category, recipe_name, recipe_price
FROM store s JOIN recipe r
ON (s.store_id = r.store_id)
ORDER BY 1;
-- 3) 가게별 매출 순위
SELECT store_name, RANK() OVER(ORDER BY store_sales DESC) 매출순위, TO_CHAR(store_sales, 'L999,999,999') || '원'
FROM store;
-- 4) 카테고리별 매출 순위
SELECT store_name, store_category, RANK() OVER(PARTITION BY store_category ORDER BY store_sales DESC) 매출순위, TO_CHAR(store_sales, 'L999,999,999') || '원'
FROM store;
-- 5) 가게명, 메뉴, 메뉴 가격 조회
SELECT store_name, menu_name, CONCAT(menu_price, '원')
FROM store JOIN menu
USING (store_id);
-- 6) 가게별 최고 금액인 메뉴 조회
WITH menuPan AS(
    SELECT menu_price, store_name, menu_name
    FROM store s JOIN menu m
    USING(store_id)
),
menuPan2 AS(
    SELECT RANK() OVER(PARTITION BY store_name ORDER BY menu_price DESC) rnum, menu_name, store_name, menu_price
    FROM menuPan
)
SELECT menu_name, store_name, menu_price
FROM menuPan2
WHERE rnum = 1
ORDER BY 3;
-- 7) 메뉴가 가장 많은 가게의 메뉴명, 메뉴 가격 조회
SELECT menu_name, menu_price
FROM menu
WHERE store_id = (
SELECT store_id
FROM (
        SELECT COUNT(menu_name) AS menu_count, store_id
        FROM menu
        GROUP BY store_id
      )
WHERE menu_count = (
                    SELECT MAX(COUNT(store_id))
                    FROM menu
                    GROUP BY store_id
                    )
);
-- 8) 0001 가게가 보유하고 있는 재료 명, 갯수 조회]
SELECT recipe_name, recipe_count
FROM recipe
WHERE store_id = 0001;

    SELECT menu_price, store_name, menu_name
    FROM store s JOIN menu m
    USING(store_id);