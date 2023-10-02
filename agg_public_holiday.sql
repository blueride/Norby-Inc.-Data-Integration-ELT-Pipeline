-- create table agg_public_holiday
CREATE TABLE c5gp015210_analytics.agg_public_holiday (
    ingestion_date DATE PRIMARY KEY NOT NULL DEFAULT CURRENT_DATE,
    tt_order_hol_jan INT NOT NULL,
    tt_order_hol_feb INT NOT NULL,
    tt_order_hol_mar INT NOT NULL,
    tt_order_hol_apr INT NOT NULL,
    tt_order_hol_may INT NOT NULL,
    tt_order_hol_jun INT NOT NULL,
    tt_order_hol_jul INT NOT NULL,
    tt_order_hol_aug INT NOT NULL,
    tt_order_hol_sep INT NOT NULL,
    tt_order_hol_oct INT NOT NULL,
    tt_order_hol_nov INT NOT NULL,
    tt_order_hol_dec INT NOT NULL
);

INSERT INTO c5gp015210_analytics.agg_public_holiday(
    tt_order_hol_jan,
    tt_order_hol_feb,
    tt_order_hol_mar,
    tt_order_hol_apr,
    tt_order_hol_may,
    tt_order_hol_jun,
    tt_order_hol_jul,
    tt_order_hol_aug,
    tt_order_hol_sep,
    tt_order_hol_oct,
    tt_order_hol_nov,
    tt_order_hol_dec
)
SELECT
    SUM(CASE WHEN d.month_of_the_year_num = 1 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_jan,
    SUM(CASE WHEN d.month_of_the_year_num = 2 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_feb,
    SUM(CASE WHEN d.month_of_the_year_num = 3 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_mar,
    SUM(CASE WHEN d.month_of_the_year_num = 4 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_apr,
    SUM(CASE WHEN d.month_of_the_year_num = 5 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_may,
    SUM(CASE WHEN d.month_of_the_year_num = 6 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_jun,
    SUM(CASE WHEN d.month_of_the_year_num = 7 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_jul,
    SUM(CASE WHEN d.month_of_the_year_num = 8 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_aug,
    SUM(CASE WHEN d.month_of_the_year_num = 9 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_sep,
    SUM(CASE WHEN d.month_of_the_year_num = 10 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_oct,
    SUM(CASE WHEN d.month_of_the_year_num = 11 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_nov,
    SUM(CASE WHEN d.month_of_the_year_num = 12 AND d.calendar_dt BETWEEN '2021-09-05'::date AND '2022-09-05'::date AND d.day_of_the_week_num BETWEEN 1 AND 5 AND d.working_day = false THEN 1 ELSE 0 END) AS tt_order_hol_dec
FROM
    c5gp015210_staging.orders o
JOIN
    if_common.dim_dates d
ON
    o.order_date::date = d.calendar_dt;

