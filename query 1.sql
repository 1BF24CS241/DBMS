select accident_date, location from accident ;
update participated set damage_amount = 25000 where reg_num = 'KA053408' and report_num = 14 ;
select * from participated ;

insert into accident values ( '16' , '2008-03-08' , 'ashok nagar');
select *from accident;

select driver_id from participated where damage_amount >=25000 ;
