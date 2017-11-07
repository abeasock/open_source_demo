# Open Source Demo

This repository contains the Dockerfile and assests used to build the Docker image shown during the open source demo.

The **Dockerfile** installs the following tools: <br>
&nbsp;&nbsp;&nbsp;- Java <br>
&nbsp;&nbsp;&nbsp;- Anaconda (Python 2.7) <br>
&nbsp;&nbsp;&nbsp;- Apache Spark 2.2.0 <br>
&nbsp;&nbsp;&nbsp;- Apache Zeppelin <br>
&nbsp;&nbsp;&nbsp;- H2O Sparkling Water <br>
&nbsp;&nbsp;&nbsp;- Apache Superset <br>
&nbsp;&nbsp;&nbsp;- Apache Livy <br>

The **assets** folder contains: <br>
&nbsp;&nbsp;&nbsp;- lending_club folder contains the lending club data <br>
&nbsp;&nbsp;&nbsp;- lending_club.db - the SQLite3 Database created for Superset <br>
&nbsp;&nbsp;&nbsp;- loans_updated.csv - loan.csv prepped for building lending_club.db <br>
&nbsp;&nbsp;&nbsp;- flask_deployment_demo - folder contains the flask app used to deploy the model built in loans.json <br>
&nbsp;&nbsp;&nbsp;- superset_dashboard_loans.pickle - the dashboard built in Superset to visualize the loan data <br>
<br>
Additional Files: <br>
run_open_source_demo.bat - file to quick start the Docker image on Windows
<br>
run_open_source_demo.sh - file to quick start the Docker image on Mac

## Getting Started
Download and install Docker. 

## Build
Steps to build a Docker image: <br>
1. Clone this repo
	git clone https://github.com/abeasock/open_source_demo.git <br>
	or <br>
	Manually download by clicking the "**Clone or Download button above**" and "**Download Zip**" <br><br>
2. Build the image <br>
   `cd <directory containing the Dockerfile>` <br>
   `docker build open_source_demo open_source_demo` <br><br>
3. Run the Docker image <br>
   `cd <directory containing the run_open_source_demo file>` <br>
   `run_open_source_demo.bat or run_open_source_demo.sh` <br><br>
4. Once everything is started up, there are a few additional set up tasks needed for the first time running the container: <br>
	1. First to run commands in a running container: <br>
	   `docker exec -it open_source_demo bash`
	2. Run the following command & the prompts below will appear in the command line to set up the user information for Superset <br>
	   *Note: Only need to create username and password, you can hit enter for other prompts to skip (i.e. first name)* <br>
	   `./assets/initial_start.sh` <br>
	   
	   ```
	   Username [admin]: 
	   User first name [admin]:
	   User last name [user]:
	   Email [admin@fab.org]:
	   Password:
	   Repeat for confirmation:
	   ```

To access Zeppelin: open Browser and go to: http://localhost:19090 <br><br>
To access Superset: open Browser and go to: http://localhost:18088 <br><br>
To run flask app run command below. Open Browser and go to: http://localhost:15555/ <br>
`/spark/bin/spark-submit --py-files /sparkling-water-2.1.14/py/build/dist/h2o_pysparkling_2.1-2.1.14.zip /assets/flask_deployment_demo/loan_app_demo.py`
