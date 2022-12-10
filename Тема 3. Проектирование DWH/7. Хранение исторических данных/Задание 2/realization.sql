-- Удалите внешний ключ из sales
ALTER TABLE public.sales DROP CONSTRAINT IF EXISTS sales_products_product_id_fk;

-- Удалите первичный ключ из products
ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_pk;

-- Добавьте новое поле id для суррогантного ключа в products
ALTER TABLE public.products
ADD COLUMN IF NOT EXISTS id serial PRIMARY KEY,
ADD COLUMN IF NOT EXISTS valid_from timestamptz,
ADD COLUMN IF NOT EXISTS valid_to timestamptz
;

-- Сделайте данное поле первичным ключом


-- Добавьте дату начала действия записи в products


-- Добавьте дату окончания действия записи в products


-- Добавьте новый внешний ключ sales_products_id_fk в sales
ALTER TABLE public.sales ADD CONSTRAINT sales_products_id_fk FOREIGN KEY (product_id) REFERENCES products (id);