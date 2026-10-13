SELECT *
FROM "Copy of Online Retail.csv"
LIMIT 10;
SELECT COUNT(*) AS total_records
FROM "Copy of Online Retail.csv";
DESCRIBE SELECT *
FROM "Copy of Online Retail.csv";
SELECT
    SUM(Quantity * UnitPrice) AS total_revenue
FROM "Copy of Online Retail.csv";
SELECT
    Description,
    SUM(Quantity) AS total_quantity_sold
FROM "Copy of Online Retail.csv"
WHERE Quantity > 0
  AND Description IS NOT NULL
GROUP BY Description
ORDER BY total_quantity_sold DESC
LIMIT 10;
SELECT
    STRFTIME(
        TRY_STRPTIME(InvoiceDate, '%m/%d/%Y %H:%M'),
        '%Y-%m'
    ) AS sales_month,
    SUM(Quantity * UnitPrice) AS monthly_revenue
FROM "Copy of Online Retail.csv"
WHERE Quantity > 0
  AND UnitPrice > 0
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS total_spending,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM "Copy of Online Retail.csv"
WHERE Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spending DESC
LIMIT 10;

SELECT
    COUNT(DISTINCT InvoiceNo) AS cancelled_invoices
FROM "Copy of Online Retail.csv"
WHERE InvoiceNo LIKE 'C%';

SELECT
    COUNT(DISTINCT CASE
        WHEN InvoiceNo LIKE 'C%' THEN InvoiceNo
    END) AS cancelled_invoices,

    COUNT(DISTINCT InvoiceNo) AS total_invoices,

    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN InvoiceNo LIKE 'C%' THEN InvoiceNo
        END)
        / COUNT(DISTINCT InvoiceNo),
        2
    ) AS cancellation_rate_percent

FROM "Copy of Online Retail.csv";