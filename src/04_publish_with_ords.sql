BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => 'YOUR_SCHEMA',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'your_schema',
    p_auto_rest_auth      => FALSE);
  COMMIT;
END;
/

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'YOUR_SCHEMA',
    p_object         => 'SAL_ORDER_DV',
    p_object_type    => 'VIEW',
    p_object_alias   => 'orders',
    p_auto_rest_auth => FALSE);   -- dev only: see the Production Checklist
  COMMIT;
END;
/
