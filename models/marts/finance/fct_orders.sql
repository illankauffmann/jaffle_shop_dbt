with orders as  (
    select * from {{ ref('stg_jaffle_shop__orders') }}
    ),

payments as (
    select 
    order_id,
    sum(amount) as amount
    from {{ ref("stg_stripe__payments") }}
    where status = 'success'
    group by order_id
)

select 
orders.order_id,
orders.customer_id,
orders.order_date,
orders.status,
payments.amount
from orders
left join payments 
using (order_id)