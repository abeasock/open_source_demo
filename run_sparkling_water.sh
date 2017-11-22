echo
echo ""
echo ""
echo ""
echo "Starting the Sparkling Water Docker Containers..."
sleep 2
docker stop sparkling_water
docker rm sparkling_water
docker run -it -d -p 18088:8088 -p 19090:8080 -p 54321:54321 -p 14444:4444 -p 15555:5555 --hostname sparkling_water --net dev --name sparkling_water open_source_demo_v6
echo ""
echo ""
echo "Starting Apache Superset on Port 18088..."
sleep 3
START docker exec sparkling_water superset runserver
echo ""
echo ""
echo "Starting Apache Zeppelin on Port 19090..."
sleep 3
START docker exec sparkling_water /zeppelin/bin/zeppelin-daemon.sh start
echo ""
echo ""
docker cp containers/spark_sparkling_water/assets sparkling_water:/.
echo ""
echo ""
echo "*****************************************************"
echo "*"
echo "*  Container has been started..."
echo "*"
echo "*  Port (Superset):  18088"
echo "*  Port (Zeppelin):  19090"
echo "*  Port (H2O):       54321"
echo "*"
echo "*  Usage: docker exec -it sparkling_water bash"
echo "*"
echo "*****************************************************"
echo ""
echo ""