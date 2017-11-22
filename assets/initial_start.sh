# Set Environmental Variables
echo "" >> ~/.bashrc
echo "export SPARK_HOME=/spark" >> ~/.bashrc
echo "export PYTHONPATH=/sparkling-water-2.1.14/py/build/dist/h2o_pysparkling_2.1-2.1.14.zip:\$PYTHONPATH" >> ~/.bashrc
echo "export PYSPARK_PYTHON=/opt/conda/bin/python2.7" >> ~/.bashrc
# Install Python packages needed for Sparkling Water
echo "[ INFO ] Install Python Packages"
pip install --trusted-host pypi.python.org tabulate
pip install --trusted-host pypi.python.org future
# Start Livy Server
echo "[ INFO ] Starting Livy Server"
export JAVA_HOME=/usr/lib/jvm/java
export SPARK_HOME=/spark
export PYTHONPATH=/sparkling-water-2.1.14/py/build/dist/h2o_pysparkling_2.1-2.1.14.zip:\$PYTHONPATH
export PYSPARK_PYTHON=/opt/conda/bin/python2.7
nohup /livy/bin/livy-server & > /dev/null
# Set Superset password
echo ""
echo ""
echo "Please create login for Superset"
fabmanager create-admin --app superset