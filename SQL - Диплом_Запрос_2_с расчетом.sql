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
select count(distinct(apr.user_id)) as users
    , count(distinct(apr.id))::float as orders
    , sum(transaction_value) as transaction_value
    , sum(commission) as commission
    , (sum(commission)::float) / sum(transaction_value) as margin_base
    , sum(processing_cost) as processing_cost
    , sum(intergtation_cost) as intergtation_cost
    , sum(promocode_cost) as promocode_cost
    , sum(processing_cost) + sum(intergtation_cost) as fixed_costs
    , avg(transaction_value) as avg_transaction_value
    , (count(distinct(apr.id))::float) / (count(distinct(apr.user_id))::float) as avg_orders_per_user
from orders_april_2021 as apr 
    inner join users_de as de
    on apr.user_id = de.id