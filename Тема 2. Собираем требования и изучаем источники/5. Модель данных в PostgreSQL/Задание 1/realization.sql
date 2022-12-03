select distinct ((event_value::JSON ->> 'product_payments')::JSON->>1)::JSON->>'product_name' as product_name
from public.outbox
where ((event_value::JSON ->> 'product_payments')::JSON->>1)::JSON->>'product_name' is not null;