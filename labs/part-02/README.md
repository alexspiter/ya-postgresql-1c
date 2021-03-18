
* select * from pg_stat_activity;
* select * from pg_available_extensions();
* select * from pg_track_settings_history;
* \d+ powa_statements_history


```
select tbl.relname, att.attname, 
       case att.attstorage
          when 'p' then 'plain'
          when 'm' then 'main'
          when 'e' then 'external'
          when 'x' then 'extended'
       end as attstorage
from pg_attribute att  
  join pg_class tbl on tbl.oid = att.attrelid   
  join pg_namespace ns on tbl.relnamespace = ns.oid   
where ns.nspname = 'public'
  and not att.attisdropped;
```

* alter table test_blob alter column column_name set storage EXTENDED;
  