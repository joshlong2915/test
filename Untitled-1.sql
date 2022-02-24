
WITH vendsku AS (
SELECT * EXCEPT(vendsku),
vendsku AS sku
FROM `maddox-600v-sandbox.600v.cross_sku2`),

specs AS (
    SELECT *, 
    "" AS mfg
    FROM `maddox-600v-sandbox.600v.mitspec`   
),

hps_mit AS (
    SELECT mit_sku,
    "Hammond" AS mfg,
    catalog_number AS sku
    FROM `maddox-600v-sandbox.600v.mit_hps_all`
),

specs_vendsku AS (
    SELECT *,
    "Hammond" AS mfg 
    FROM vendsku FULL JOIN specs USING(mit_sku,mfg)
),
hspecs AS (
    SELECT * EXCEPT(catalog_number),
    'New' As condition,
    catalog_number AS sku,
    'Hammond' AS mfg
    FROM `maddox-600v-sandbox.hps.hps_spec`
    ORDER BY sku ASC),

list AS (
SELECT * FROM specs_vendsku 
FULL JOIN hps_mit USING(mit_sku,sku)
FULL JOIN hspecs USING(
conductor
,condition	
,duty	
,e_shield	
,enclosure_type	
,frequency	
,insulation_class	
,isolation	
,kva	
,nema_rating	
,p_volt	
,s_volt	
,p_wind	
,s_wind	
,k_rating	
,winding_type	
,temp_rise	
,phase	
,sku

)),

list2 AS (
SELECT
mit_sku,
kva,
p_volt,
p_wind,
s_volt,
s_wind,
conductor,
temp_rise,
winding_type,
enclosure_type,
nema_rating,
duty
FROM list
--FULL JOIN specs USING(mit_sku,kva,p_volt,p_wind,s_volt,s_wind,conductor,temp_rise,winding_type,enclosure_type,nema_rating,duty,mfg)