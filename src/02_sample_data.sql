INSERT INTO sal_customers (cust_code, cust_name, cust_email, cust_city, cust_country)
VALUES ('C-1001', 'Brandt Logistik GmbH', 'einkauf@brandt-logistik.example', 'Hamburg', 'DE');
INSERT INTO sal_customers (cust_code, cust_name, cust_email, cust_city, cust_country)
VALUES ('C-1002', 'Northbridge Consulting Ltd', 'it@northbridge.example', 'Manchester', 'GB');
INSERT INTO sal_customers (cust_code, cust_name, cust_email, cust_city, cust_country)
VALUES ('C-1003', 'Van Dijk Architecten B.V.', 'office@vandijk.example', 'Utrecht', 'NL');
INSERT INTO sal_customers (cust_code, cust_name, cust_email, cust_city, cust_country)
VALUES ('C-1004', 'Alpine Medical AG', 'procurement@alpinemedical.example', 'Innsbruck', 'AT');

INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('LAP-NB14-PRO', 'Nexa Book 14 Pro',          'Laptops',     1249);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('LAP-AR13-AIR', 'Aero 13 Air',               'Laptops',      999);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('MON-CV27-QHD', 'ClearView 27 QHD',          'Monitors',     329);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('MON-UW34-CRV', 'UltraWide 34 Curved',       'Monitors',     649);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('PER-KB-MX01',  'Silent Mechanical Keyboard','Peripherals',  119);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('PER-MS-ERG1',  'Ergo Vertical Mouse',       'Peripherals',  59.9);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('ACC-DCK-USC',  'USB-C Docking Station',     'Accessories',  199);
INSERT INTO sal_products (prod_sku, prod_name, prod_category, prod_unit_price) VALUES ('ACC-HS-ANC',   'ANC Office Headset',        'Accessories',  149);

INSERT INTO sal_orders (ordr_no, ordr_cust_fk, ordr_status, ordr_note)
SELECT 'SO-2026-0001', cust_id, 'CONFIRMED', 'Workstations for the new Hamburg office' FROM sal_customers WHERE cust_code = 'C-1001';
INSERT INTO sal_orders (ordr_no, ordr_cust_fk, ordr_status, ordr_note)
SELECT 'SO-2026-0002', cust_id, 'NEW', 'Two consultant laptops' FROM sal_customers WHERE cust_code = 'C-1002';
INSERT INTO sal_orders (ordr_no, ordr_cust_fk, ordr_status, ordr_note)
SELECT 'SO-2026-0003', cust_id, 'SHIPPED', 'Design studio monitors' FROM sal_customers WHERE cust_code = 'C-1003';

-- order lines: the price is copied from the catalog at order time
INSERT INTO sal_order_lines (orli_ordr_fk, orli_prod_fk, orli_qty, orli_unit_price)
SELECT o.ordr_id, p.prod_id, x.qty, p.prod_unit_price
FROM  (SELECT 'SO-2026-0001' ordr_no, 'LAP-NB14-PRO' sku, 5 qty FROM dual UNION ALL
       SELECT 'SO-2026-0001', 'MON-CV27-QHD', 5 FROM dual UNION ALL
       SELECT 'SO-2026-0001', 'ACC-DCK-USC',  5 FROM dual UNION ALL
       SELECT 'SO-2026-0002', 'LAP-AR13-AIR', 2 FROM dual UNION ALL
       SELECT 'SO-2026-0002', 'ACC-HS-ANC',   2 FROM dual UNION ALL
       SELECT 'SO-2026-0003', 'MON-UW34-CRV', 3 FROM dual UNION ALL
       SELECT 'SO-2026-0003', 'PER-KB-MX01',  3 FROM dual) x
JOIN   sal_orders   o ON o.ordr_no  = x.ordr_no
JOIN   sal_products p ON p.prod_sku = x.sku;

COMMIT;
