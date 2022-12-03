select distinct ((event_value::JSON ->> 'product_payments')::JSON->>1)::JSON->>'product_name'
from public.outbox;