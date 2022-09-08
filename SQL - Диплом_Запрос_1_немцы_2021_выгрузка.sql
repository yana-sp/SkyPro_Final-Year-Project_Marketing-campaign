with orders_april_2021 as 
    (select *
    from exam.orders 
    where created_date between '2021-04-01 00:00' and '2021-04-30 23:59'
    ),
    users_de as 
(select users.id
    , users.status
    , region.language
    from exam.users as users 
        join exam.region as region 
        on users.region_id = region.id
    where users.status = 'active'
      and region.language = 'de'
    )
select *
from orders_april_2021 as apr 
    inner join users_de as de
    on apr.user_id = de.id