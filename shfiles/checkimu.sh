gnome-terminal --window -e 'bash -c "sudo chmod 777 /dev/ttyACM0; exec bash"' \
--tab -e 'bash -c "sleep 3; roslaunch mavros px4.launch; exec bash"' \
--tab -e 'bash -c "sleep 4; rostopic hz /mavros/imu/data_raw; exec bash"' \

