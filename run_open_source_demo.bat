@echo off
echo.
echo.
echo.
echo Starting the Open Source Demo Docker Container...
sleep 2
docker stop open_source_demo
docker rm open_source_demo
docker run -it -d -p 18088:8088 -p 19090:8080 -p 54321:54321 -p 14444:4444 -p 15555:5555 -p 4040:4040 -p 4041:4041 -p 4042:4042 --hostname open_source_demo --net dev --name open_source_demo open_source_demo
echo.
echo.
echo Starting Apache Superset on Port 18088...
sleep 3
START docker exec open_source_demo superset runserver
echo.
echo.
echo Starting Apache Zeppelin on Port 19090...
sleep 3
START docker exec open_source_demo /zeppelin/bin/zeppelin-daemon.sh start
echo.
echo.
docker cp ./assets open_source_demo:/.
echo.
echo.
echo *****************************************************
echo 
echo *  Container has been started...
echo *
echo *  Port (Superset):  18088
echo *  Port (Zeppelin):  19090
echo *  Port (H2O):       54321
echo *
echo *  Usage: docker exec -it open_source_demo bash
echo *
echo *****************************************************
echo.
echo.