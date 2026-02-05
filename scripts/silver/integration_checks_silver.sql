-- Checking relation between (crm_prd_info) and (crm_sales_details) on product key
select * ,
SUBSTRING (prd_key, 7,len(prd_key)) as new_prd_key
from bronze.crm_prd_info 
where SUBSTRING (prd_key, 7,len(prd_key)) not in 
(select sls_prd_key from bronze.crm_sales_details)



-- Checking relation between (crm_prd_info) and (erp_px_cat_g1v2) on category id
select * ,
REPLACE ( SUBSTRING (prd_key, 1,5), '-','_')
from bronze.crm_prd_info 
where REPLACE ( SUBSTRING (prd_key, 1,5), '-','_') not in 
(select id from bronze.erp_px_cat_g1v2)



-- Checking relation between (crm_sales_details) and (crm_cust_info) on customer id
select * from bronze.crm_sales_details 
where sls_cust_id not in 
(select cst_id from silver.crm_cust_info)



-- Checking relation between (erp_cust_za12) and (crm_cust_info) on customer id
select * ,
case when cid like 'NAS%'
then SUBSTRING (cid,4,LEN(trim(cid)))
else cid
end new_cid
from bronze.erp_cust_az12 
where case when cid like 'NAS%'
then SUBSTRING (cid,4,LEN(trim(cid)))
else cid
end  not in
(select cst_key from silver.crm_cust_info)



-- Checking relation between (erp_loc_a101) and (crm_cust_info) on customer id
select *,
REPLACE (cid ,'-' ,'') as new_cid
from bronze.erp_loc_a101 
where REPLACE (cid ,'-' ,'') not in
(select cst_key from silver.crm_cust_info)
