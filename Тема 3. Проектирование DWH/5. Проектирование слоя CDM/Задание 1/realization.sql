create table cdm.dm_settlement_report (
id serial not null,
restauranr_id varchar(255) not null,
restauranr_name varchar(255) not null,
settlement_date date not null,
orders_count int not null,
orders_total_sum numeric(14,2) not null,
orders_bonus_payment_sum numeric(14,2) not null,
orders_bonus_granted_sum numeric(14,2) not null,
order_processing_fee numeric(14,2) not null,
restaraunt_reward_sum numeric(14,2) not null);
)