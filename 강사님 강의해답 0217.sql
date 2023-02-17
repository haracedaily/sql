--------����
-- 1) ��� �Ĵ� ����Ʈ ��ȸ
SELECT * FROM store;
-- 2) ���Ժ� ���Ը�, ī�װ�, ��� ���, ��� ���� ��ȸ
SELECT store_name, store_category, recipe_name, recipe_price
FROM store s JOIN recipe r
ON (s.store_id = r.store_id)
ORDER BY 1;
-- 3) ���Ժ� ���� ����
SELECT store_name, RANK() OVER(ORDER BY store_sales DESC) �������, TO_CHAR(store_sales, 'L999,999,999') || '��'
FROM store;
-- 4) ī�װ��� ���� ����
SELECT store_name, store_category, RANK() OVER(PARTITION BY store_category ORDER BY store_sales DESC) �������, TO_CHAR(store_sales, 'L999,999,999') || '��'
FROM store;
-- 5) ���Ը�, �޴�, �޴� ���� ��ȸ
SELECT store_name, menu_name, CONCAT(menu_price, '��')
FROM store JOIN menu
USING (store_id);
-- 6) ���Ժ� �ְ� �ݾ��� �޴� ��ȸ
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
-- 7) �޴��� ���� ���� ������ �޴���, �޴� ���� ��ȸ
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
-- 8) 0001 ���԰� �����ϰ� �ִ� ��� ��, ���� ��ȸ]
SELECT recipe_name, recipe_count
FROM recipe
WHERE store_id = 0001;

    SELECT menu_price, store_name, menu_name
    FROM store s JOIN menu m
    USING(store_id);