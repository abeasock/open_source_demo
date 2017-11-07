# Open Source Demo

This repository contains the Dockerfile and assests used to build the Docker image shown during the open source demo.

The Dockerfile installs the following tools:

	- Java
	- Anaconda (Python 2.7)
	- Apache Spark 2.2.0
	- Zeppelin
	- H2O Sparkling Water
	- Apache Superset
	- Apache Livy

The assets folder contains:

	- lending_club folder contains the lending club data
	- lending_club.db - the SQLite3 Database created for Superset
	- loans_updated.csv - loan.csv prepped for building lending_club.db
	- flask_deployment_demo - folder contains the flask app used to deploy the H2O model built in the Zeppelin notebook loans.json
	- superset_dashboard_loans.pickle - the dashboard built in Superset to visualize the loan data

run_open_source_demo.bat - file to quick start the Docker image on Windows
run_open_source_demo.sh - file to quick start the Docker image on Mac


## Getting Started
Download and install Docker. 

## Build
Steps to build a Docker image: <br>
1. Clone this repo
	git clone https://github.com/abeasock/open_source_demo <br>
	or <br>
	Manually download by clicking the "**Clone or Download button above**" and "**Download Zip**" <br><br>
2. Build the image <br>
    cd <directory containing the Dockerfile> <br>
   `docker build open_source_demo open_source_demo` <br><br>
3. Run the Docker image <br>
   `cd <directory containing the run_open_source_demo file>` <br>
   `run_open_source_demo.bat or run_open_source_demo.sh` <br><br>
4. Once everything is started up, there are a few additional set up tasks needed for the first time running the container: <br>
	1. First to run commands in a running container:
			docker exec -it open_source_demo bash 
	2. Run the command & follow the prompts to set up the user information for Superset
			./assets/initial_start.sh



		To access Zeppelin: open Browser and go to: http://localhost:19090
		To access Superset: open Browser and go to: http://localhost:18088
		To run flask app run command below. Open Browser and go to: http://localhost:15555/ 
			/spark/bin/spark-submit --py-files /sparkling-water-2.1.14/py/build/dist/h2o_pysparkling_2.1-2.1.14.zip /assets/flask_deployment_demo/loan_app_demo.py



