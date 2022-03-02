 #OUIrMd1@6
 172.16.96.21
 
 do
 $sql$
 declare
 r_tabelas record;

 begin

 for r_tabelas in

 select
  'alter table '||p.oid::regclass||' set WITHOUT oids;' as alter_table
 from pg_class p
 inner join pg_stat_user_tables u on u.relid=p.oid
 where
  p.relhasoids

 loop
  raise notice '%',r_tabelas.alter_table;
  execute r_tabelas.alter_table;

 end loop;
end
$sql$


drop aggregate if exists gazin.array_accum (pg_catalog.anyelement);
drop aggregate if exists gazin.array_accum (pg_catalog.anyelement);
drop aggregate if exists array_accum ( anyelement) ;
drop aggregate if exists array_append(anyarray, anyelement);
drop aggregate if exists gazin.array_accum_cat (pg_catalog.anyarray);
revoke all on pg_catalog.pg_pltemplate from programacao;
drop trigger tr_usuario_validasegurancasenha ON glb.usuario;
drop function gazin.validasegurancasenha ( integer, integer, character varying, character varying) ;
alter table gazin.sequences alter COLUMN sequence_catalog type varchar(100); 
alter table gazin.sequences alter COLUMN sequence_schema type varchar(100);
alter table gazin.sequences alter sequence_name type varchar(100);


