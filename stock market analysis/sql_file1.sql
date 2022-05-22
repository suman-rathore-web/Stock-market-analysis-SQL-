create database Assignment;                                        -- created database
use Assignment;
show tables;
describe bajaj_auto;
describe eicher_motors;
describe hero_motocorp;
describe infosys;
describe tcs;
describe tvs_motors;


-- created function for date

DELIMITER $$                                                         
create function get_date(file_date varchar(20))
returns  varchar(2) deterministic
BEGIN 
declare format_date varchar(2);
if file_date='January' then
	set format_date= '1';
elseif  file_date='February' then
	set format_date= '2';
elseif file_date='March' then
	set format_date= '3';
elseif file_date='April' then
	set format_date= '4';
elseif  file_date='May' then
	set format_date= '5';
elseif file_date='June' then
	set format_date= '6';
elseif file_date='July' then
	set format_date= '7';
elseif  file_date='August' then
	set format_date= '8';
elseif file_date='September' then
	set format_date='9';
elseif file_date='October' then
	set format_date='10';
elseif  file_date='November' then
	set format_date= '11';
else
	set format_date= '12';
end if;
return format_date;
END $$


 -- creating function for month
 
DELIMITER $$                                                                
create function get_month(date varchar(20))
returns varchar(20) deterministic
BEGIN
return (select SUBSTRING_INDEX(SUBSTRING_INDEX(Date,'-',2),'-',-1));
END $$ DELIMITER ;

  -- updating dates and months 

 update bajaj_auto
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
 update eicher_motors
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
 update hero_motocorp
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
 update infosys
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
 update tcs
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
  update tvs_motors
 set Date=(select replace(Date,get_month(Date),get_date(get_month(Date))));
 
 
 
 
 -- TASK 1: Creating tables bajaj1, eicher1, hero1, infosys1, tc1, tvs1
 
create table bajaj1 as                                                                            -- creating bajaj1 
	select `Date`,`Close Price`,
avg(`Close Price`) over(order by `Date` rows between 19 preceding and current row) as '20 Day MA',
avg(`Close Price`) over(order by `Date` rows between 49 preceding and current row) as '50 Day MA'
 from bajaj_auto;
 update bajaj1                                                                                     -- updaing bajaj1
 set `20 Day MA` = NULL limit 19;
 update bajaj1
 set `50 Day MA` = NULL limit 49;
 
  create table eicher1 as                                                                           -- creating eicher1 
	select `Date`,`Close Price`,
avg(`Close Price`) over(order by `Date` rows between 19 preceding and current row) as '20 Day MA',
avg(`Close Price`) over(order by `Date` rows between 49 preceding and current row) as '50 Day MA'
 from eicher_motors;
 update eicher1                                                                                      -- updating eicher1 
 set `20 Day MA` = NULL limit 19;
 update eicher1
 set `50 Day MA` = NULL limit 49;
 
 create table hero1 as                                                                               -- creating hero1
	select `Date`,`Close Price`,
avg(`Close Price`) over(order by `Date` rows between 19 preceding and current row) as '20 Day MA',
avg(`Close Price`) over(order by `Date` rows between 49 preceding and current row) as '50 Day MA'
 from hero_motocorp;
 update hero1                                                                                         -- updating hero1
 set `20 Day MA` = NULL limit 19;
 update hero1
 set `50 Day MA` = NULL limit 49; 
 
 Create table infosys1                                                                                  -- craeting infosys1
 select `Date`,`Close price`,
 avg(`Close price`) over(order by `Date` rows  between 19 preceding and current row) as '20 Day MA',
 avg(`Close price`) over(order by `Date` rows  between 49 preceding and current row) as '50 Day MA'
 from infosys;                                                                                            
  update infosys1                                                                                         -- updating infosys1
 set `20 Day MA` = NULL limit 19;
 update infosys1
 set `50 Day MA` = NULL limit 49;

  Create table tcs1                                                                                       -- creating tcs1
 select `Date`,`Close price`,
 avg(`Close price`) over(order by `Date` rows  between 19 preceding and current row) as '20 Day MA',
 avg(`Close price`) over(order by `Date` rows  between 49 preceding and current row) as '50 Day MA'
 from tcs;
  update tcs1                                                                                             -- updating tcs1
 set `20 Day MA` = NULL limit 19;
 update tcs1
 set `50 Day MA` = NULL limit 49;
 
 
 Create table tvs1                                                                                         -- creating tvs1
 select `Date`,`Close price`,
 avg(`Close price`) over(order by `Date` rows  between 19 preceding and current row) as '20 Day MA',
 avg(`Close price`) over(order by `Date` rows  between 49 preceding and current row) as '50 Day MA'
 from tvs_motors;                    
 update tvs1                                                                                               -- updating tvs1
 set `20 Day MA` = NULL limit 19;
 update tvs1
 set `50 Day MA` = NULL limit 49;
 
 
 -- describe tables
 describe bajaj1;                                                      
 describe eicher1;
 describe hero1;
 describe infosys1;
 describe tcs1;
 describe tvs1;
 
 select * from bajaj1;
 select * from eicher1;
 select * from hero1;
 select * from infosys1;
 select * from tcs1;
 select * from tvs1;
 
 -- TASK 1 COMPLETED
 
 
 
 -- TASK 2:  Create a master table containing the date and close price of all the six stocks
 
 create table master_table
 select tcs.`Date`,b.`Close price` as 'Bajaj',
 tcs.`Close price` as 'TCS' ,tvs.`Close price` as 'TVS',
 i.`Close price` as 'Infosys',e.`Close price` as 'Eicher',
 h.`Close price` as 'Hero'
 from tcs  inner join eicher_motors e on e.`Date`=tcs.`Date`
 inner join  tvs_motors tvs on tvs.`Date`= tcs.`Date`
 inner join  hero_motocorp h on h.`Date` = tcs.`Date`
 inner join  bajaj_auto b on b.`Date`=tcs.`Date`
 inner join  infosys i on i.`Date`=tcs.`Date` order by tcs.`Date`;
 
 select * from master_table;
 
 -- TASK 2 COMPLETED 
 
 
 /* TASK 3: Use the table created in Part(1) to generate buy and sell signal. 
 Store this in another table named 'bajaj2'. Perform this operation for all stocks.*/
 
 create table bajaj2                                                                                                        -- for bajaj2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from bajaj1 ;
 
 
 create table eicher2                                                                                                         -- for eicher2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from eicher1;
 
 
 create table hero2                                                                                                             -- for hero2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from hero1 ;
 
 
  create table infosys2                                                                                                      -- for infosys2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from infosys1 ;
 
 
  create table tcs2                                                                                                            -- for tcs2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from tcs1 ;
 
 
 create table tvs2                                                                                                              -- for tvs2
 select `Date`,`Close price`,
 case 
 when `50 Day MA` is NULL then 'NA'
 when `20 Day MA`>`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))<(lag(`50 Day MA`,1) over(order by `Date`))) then 'BUY'
 when `20 Day MA`<`50 Day MA` and ((lag(`20 Day MA`,1) over(order by `Date`))>(lag(`50 Day MA`,1) over(order by `Date`))) then 'SELL'
 else 'HOLD' 
 end as `Signal`
 from tvs1 ;
 
 
 select * from bajaj2;
 select * from eicher2;
 select * from hero2;
 select * from infosys2;
 select * from tcs2;
 select * from tvs2;
 
 -- TASK 3 COMPLETED
 
 
 
 /* TASK 4: Create a User defined function, that takes the date as input and returns 
 the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock.*/
 
 -- creating function get_signal
  DELIMITER $$                                                                                  
 create function get_signal(input_date date)
 returns varchar(20) deterministic
 BEGIN
 return (select `Signal` from bajaj2 where bajaj2.`Date` = input_date);
 END $$ DELIMITER ;
  

 select get_signal(`Date`),`Date` as 'Signal' from bajaj_auto;
 select get_signal('2018-06-21');

 select get_signal('2018-05-29');
 
 select get_signal('2018-05-30');

 select get_signal('2015-01-01');


 
 -- TASK 4 COMPLETED
 
 
 
 
 
 
 
 
 
 
 
 