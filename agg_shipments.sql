-- create agg_shipment table
CREATE TABLE c5gp015210_analytics.agg_shipments (
    ingestion_date DATE PRIMARY KEY NOT NULL DEFAULT CURRENT_DATE,
    tt_late_shipments INT NOT NULL,
    tt_undelivered_items INT NOT NULL
);

-- Insert data into table
INSERT INTO c5gp015210_analytics.agg_shipments 
(tt_late_shipments, tt_undelivered_items)

WITH
	late_shipments AS (
    SELECT COUNT(*) AS tt_late_shipments
    FROM c5gp015210_staging.shipments_deliveries s
    JOIN c5gp015210_staging.orders o
    ON s.order_id = o.order_id 
    WHERE
	o.order_date >= '2021-09-05'::date
    AND o.order_date < '2022-09-05'::date
	AND
	s.shipment_date >= o.order_date 
	+ INTERVAL '6 days' AND s.delivery_date IS NULL
),
	undelivered_shipment AS (
    SELECT COUNT(*) AS tt_undelivered_shipments
    FROM c5gp015210_staging.shipments_deliveries s
    JOIN c5gp015210_staging.orders o
    ON s.order_id = o.order_id 
    WHERE
    o.order_date >= '2021-09-05'::date
    AND o.order_date < '2022-09-05'::date
    AND s.delivery_date IS NULL
    AND s.shipment_date IS NULL
    AND o.order_date + INTERVAL '15 days' >= '2022-09-05'::DATE
)

SELECT tt_late_shipments, tt_undelivered_shipments 
FROM late_shipments, undelivered_shipment; 
