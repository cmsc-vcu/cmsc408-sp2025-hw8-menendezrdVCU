# task 15
select
 `Region`, 
 SUM(High) as 'High',
 SUM(Low) as 'Low',
 SUM(`Lower middle`) as 'Lower middle',
 SUM(`Upper middle`) as 'Upper middle',
 SUM(`High`+ `Low`+ `Lower middle`+ `Upper middle`) as 'Total'
from 
(select `Region`,`Short Name`,
 case when `Income group`='High income' then 1 else 0 end as 'High',
 case when `Income group`='Low income' then 1 else 0 end as 'Low',
 case when `Income group`='Lower middle income' then 1 else 0 end as 'Lower middle',
 case when `Income group`='Upper middle income' then 1 else 0 end as 'Upper middle' 
from wdi_country order by `Region`) as Task15
Group by
 `Region`

select `Region`, `Short name`, count(*) as pair_cnt from wdi_country group by `Region`, `Short name`

#cte
# region_cnt, income_cnt, total_cnt
// y.`Region`,y.`Income Group`, pair_cnt, region_cnt, income_cnt, total_cnt, `Pct of Total`

with t1 as (select `Region`,`Income Group`, count(*) as pair_cnt from wdi_country group by `Region`, `Income Group`),
    t2 as (SELECT `Region`,count(*) as region_cnt from wdi_country GROUP BY `Region`),
    t3 as (SELECT `Income Group`,count(*) as income_cnt from wdi_country Group by `Income group`),
    t4 as (SELECT count(*) as total_cnt from wdi_country),
 Task19 as(
select t1.`Region`, t1.`Income Group`, pair_cnt, region_cnt, income_cnt, total_cnt, round(avg((pair_cnt/total_cnt)*100), 1) as "Pct of Total"
from t1 left join t2 on t1.Region=t2.Region left join t3 on t1.`Income Group`=t3.`Income Group` join t4
group by t1.`Region`, t1.`Income Group`, pair_cnt, region_cnt, income_cnt, total_cnt
), v1 as (
select Region,
case when `Income group`='Low income' then `Pct of Total` else 0 end as 'Low Income',
 case when `Income group`='Lower middle income' then `Pct of Total` else 0 end as 'Lower Middle',
 case when `Income group`='Upper middle income' then `Pct of Total` else 0 end as 'Upper Middle',
case when `Income group`='High income' then `Pct of Total` else 0 end as 'High Income'
from Task19
)
select Region,
sum(`Low Income`) as 'Low Income',
sum(`Lower Middle`) as 'Low Middle',
sum(`Upper Middle`) as 'Upper Middle',
sum(`High Income`) as 'High Income',
sum(`Low Income`+`Lower Middle`+`Upper Middle`+`High Income`) as 'Row Total'
from v1
group by Region


with t1 as (select `Region`,`Income Group`, count(*) as pair_cnt from wdi_country group by `Region`, `Income Group`),
    t2 as (SELECT `Region`,count(*) as region_cnt from wdi_country GROUP BY `Region`),
    t3 as (SELECT `Income Group`,count(*) as income_cnt from wdi_country Group by `Income group`),
    t4 as (SELECT count(*) as total_cnt from wdi_country)
select `Income group`, income_cnt, total_cnt, round(avg((income_cnt/total_cnt)*100), 1) as 'Pct of Total'
from t3 join t4
Group by `Income group`, income_cnt, total_cnt




