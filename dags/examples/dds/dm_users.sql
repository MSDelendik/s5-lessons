INSERT INTO dds.dm_users
SELECT
id,
object_value::JSON ->> '_id' AS user_id,
object_value::JSON ->> 'name' AS user_name,
object_value::JSON ->> 'login' AS user_login,
from stg.ordersystem_users
WHERE object_value::JSON ->> 'login' IS NOT NULL
ORDER BY 1
ON CONFLICT (id) DO UPDATE
SET
user_id = EXCLUDED.user_id
user_name = EXCLUDED.user_name
user_login = EXCLUDED.user_login;