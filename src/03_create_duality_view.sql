CREATE OR REPLACE JSON RELATIONAL DUALITY VIEW sal_order_dv AS
SELECT JSON {
  '_id'       : o.ordr_id,
  'orderNo'   : o.ordr_no,
  'orderDate' : o.ordr_date,
  'status'    : o.ordr_status,
  'note'      : o.ordr_note,
  'customer'  : (SELECT JSON {
                   'customerId' : c.cust_id,
                   'code'       : c.cust_code,
                   'name'       : c.cust_name,
                   'email'      : c.cust_email,
                   'city'       : c.cust_city,
                   'country'    : c.cust_country
                 }
                 FROM sal_customers c WITH NOINSERT NOUPDATE NODELETE
                 WHERE c.cust_id = o.ordr_cust_fk),
  'lines'     : [ SELECT JSON {
                    'lineId'    : l.orli_id,
                    'quantity'  : l.orli_qty,
                    'unitPrice' : l.orli_unit_price,
                    'product'   : (SELECT JSON {
                                     'productId' : p.prod_id,
                                     'sku'       : p.prod_sku,
                                     'name'      : p.prod_name,
                                     'category'  : p.prod_category
                                   }
                                   FROM sal_products p WITH NOINSERT NOUPDATE NODELETE
                                   WHERE p.prod_id = l.orli_prod_fk)
                  }
                  FROM sal_order_lines l WITH INSERT UPDATE DELETE
                  WHERE l.orli_ordr_fk = o.ordr_id ]
}
FROM sal_orders o WITH INSERT UPDATE DELETE;
