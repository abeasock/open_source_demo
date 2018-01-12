Create table loans_v3(id integer,  
						loan_amnt double, 
						term varchar, 
						int_rate double, 
						installment double, 
						grade varchar, 
						emp_length varchar, 
						home_ownership varchar, 
						addr_state varchar, 
						annual_inc double, 
						revol_bal double, 
						tot_coll_amt double, 
						revol_util double,
						issue_d date,
						addr_state_cd varchar,
						purpose varchar,
						loan_status varchar);
.mode csv loans_v3
.import loans_updated.csv loans_v3
.quit
