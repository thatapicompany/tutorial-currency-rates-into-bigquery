WITH latest_response as (

    SELECT  
        timestamp,
        JSON_EXTRACT(data, '$.rates') as rates
    FROM 
    ( 
        -- order by timestamp to get the latest
        select 
            timestamp,
            data ,
            ROW_NUMBER() OVER (PARTITION BY data ORDER BY timestamp desc ) as rowNumber--add row number to enable filtering to latest

        -- Update this is you have used a different dataset or table name
        FROM currency_rates.openexchangerates_responses responses
    )
    WHERE 
        -- swap out for your own currency assuming you updated API request too
        JSON_EXTRACT_SCALAR(data, '$.base') = "USD"

        and rowNumber=1-- Get the latest row

), parsed_data as (
    
    SELECT 
        *,
        SPLIT(pair, ':') AS currencyKeyValues 
        FROM
        (
            SELECT 
                timestamp,
                "USD" AS base_currency,
                 REGEXP_EXTRACT_ALL(rates, r'"[^"]+":\d+\.?\d*') AS pair
            FROM latest_response
        )
    CROSS JOIN UNNEST (pair) AS pair
)

SELECT 
    timestamp as last_updated, 
    base_currency,  
    currencyKeyValues[offset(0)] AS currency,  
    currencyKeyValues[offset(1)] AS rate
FROM parsed_data