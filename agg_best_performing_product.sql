-- Create the best_performing_product table with "ingestion_date" as the primary key
CREATE TABLE c5gp015210_analytics.best_performing_product (
    ingestion_date DATE PRIMARY KEY NOT NULL DEFAULT CURRENT_DATE,
    product_name VARCHAR NOT NULL,
    most_ordered_day DATE NOT NULL,
    is_public_holiday BOOLEAN NOT NULL,
    tt_review_points INT NOT NULL,
    pct_one_star_review FLOAT NOT NULL,
    pct_two_star_review FLOAT NOT NULL,
    pct_three_star_review FLOAT NOT NULL,
    pct_four_star_review FLOAT NOT NULL,
    pct_five_star_review FLOAT NOT NULL,
    pct_early_shipments FLOAT NOT NULL,
    pct_late_shipments FLOAT NOT NULL
);

-- Insert data into best_performing_product table
INSERT INTO c5gp015210_analytics.best_performing_product (
    product_name,
    most_ordered_day,
    is_public_holiday,
    tt_review_points,
    pct_one_star_review,
    pct_two_star_review,
    pct_three_star_review,
    pct_four_star_review,
    pct_five_star_review,
    pct_early_shipments,
    pct_late_shipments
)
WITH ProductReviews AS (
    SELECT
        p.product_name,
        DATE_TRUNC('day', o.order_date)::DATE AS most_ordered_day,
        CASE
            WHEN d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN true 
            ELSE false
            END AS is_public_holiday,
        SUM(r.review) AS tt_review_points,
        COUNT(CASE WHEN r.review = 1 THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS pct_one_star_review,
        COUNT(CASE WHEN r.review = 2 THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS pct_two_star_review,
        COUNT(CASE WHEN r.review = 3 THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS pct_three_star_review,
        COUNT(CASE WHEN r.review = 4 THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS pct_four_star_review,
        COUNT(CASE WHEN r.review = 5 THEN 1 ELSE NULL END) * 100.0 / COUNT(*) AS pct_five_star_review,
        SUM(CASE WHEN s.shipment_date >= o.order_date + INTERVAL '6 days' AND s.delivery_date IS NULL THEN 0 ELSE 1 END) * 100.0 / COUNT(*) AS pct_early_shipments,
        SUM(CASE WHEN s.shipment_date >= o.order_date + INTERVAL '6 days' AND s.delivery_date IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_late_shipments
    FROM
    c5gp015210_staging.reviews r
    JOIN
    if_common.dim_products p
    ON
    r.product_id = p.product_id
    JOIN
    c5gp015210_staging.orders o
    ON
    r.product_id = o.product_id 
    JOIN
    c5gp015210_staging.shipments_deliveries s
    ON
    o.order_id = s.order_id
    JOIN
    if_common.dim_dates d
    ON
    o.order_date::DATE = d.calendar_dt
    WHERE
        o.order_date >= '2021-09-05'::date
        AND o.order_date < '2022-09-05'::date
    GROUP BY
        p.product_name, most_ordered_day, is_public_holiday
)
SELECT
    product_name,
    most_ordered_day,
    is_public_holiday,
    tt_review_points,
    pct_one_star_review,
    pct_two_star_review,
    pct_three_star_review,
    pct_four_star_review,
    pct_five_star_review,
    pct_early_shipments,
    pct_late_shipments
FROM (
    SELECT
        product_name,
        most_ordered_day,
        is_public_holiday,
        tt_review_points,
        pct_one_star_review,
        pct_two_star_review,
        pct_three_star_review,
        pct_four_star_review,
        pct_five_star_review,
        pct_early_shipments,
        pct_late_shipments,
        RANK() OVER (ORDER BY tt_review_points DESC) AS review_rank
    FROM
        ProductReviews
) AS RankedProductReviews
WHERE
    review_rank = 1;











