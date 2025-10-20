# LIO-DRONE-250

- **Perception & Estimation:** LiDAR-Inertial Odometry (LIO) provides robust real-time state estimation and a local map.
- **Planning:** The Ego-Planner generates kinodynamically feasible, collision-free trajectories in real time.
- **Control:** The px4ctrl interface forwards the planned trajectories from the onboard computer to the PX4 flight stack for stable and precise execution.

## 1.Results

https://github.com/user-attachments/assets/9b0e405b-c860-414f-a51e-c59a6a6c4f74

https://github.com/user-attachments/assets/76426b22-1975-4e26-80c9-29b1ade04c31

## 2.Preparation

In order to run the project, first you need to make some preliminary preparations:

### 2.1 Installing XTDrone

Please follow the tutorial link [XTDrone](https://www.yuque.com/xtdrone/manual_cn/install_scripts) to install XTDrone and ensure that it can run in the Gazebo environment, Please refer to **extra.zip** for relevant configuration files.

### 2.2 Building ROS workspace

```c++
$ cd {work_space}
$ git clone https://github.com/XuX-HNU/LIO-DRONE-250.git
```

Before compiling the entire project, you need to compile some dependency packages first

#### 2.2.1Sophus

Sophus Installation for the non-templated/double-only version.

```c++
$ cd  {work_space}/src/utils
$ git clone  https://github.com/strasdat/Sophus.git
$ cd Sophus
$ git checkout a621ff
$ mkdir build && cd build && cmake ..
$ make
$ sudo make install
```

#### 2.2.2Vikit

Vikit contains camera models, some math and interpolation functions that we need. Vikit is a catkin project, therefore, download it into your catkin workspace source folder.

```c++
$ cd  {work_space}/src/utils
$ git clone  https://github.com/xuankuzcr/rpg_vikit.git  
```

#### 2.2.3LIvox-SDK2

```c++
$ git clone  https://github.com/Livox-SDK/Livox-SDK2.git
$ cd ./Livox-SDK2/
$ mkdir build
$ cd build
$ cmake .. && make -j
$ sudo make install
```

#### 2.2.4Mid360_imu_sim

Building Gazebo simulation plugin

```c++
$ cd  {work_space}/src/HIGH_FAST_LIO
$ git clone  https://github.com/qiurongcan/Mid360_imu_sim.git
```

#### 2.2.5livox_ros_driver2

```c++
$ cd  {work_space}/src
$ git clone  https://github.com/Livox-SDK/livox_ros_driver2.git
$ cd livox_ros_driver2
$ ./build.sh ROS1
```

Then, you can **cd {work_space}** and run **catkin_make**

## 3.Simulation

In Terminal 1

```c++
$ roslaunch px4 single_vehicle.launch
```

In Terminal 2

```c++
$ cd {work_space}/src/HIGH_FAST_LIO/Mid360_imu_sim/script
$ python3 pointcloud2livox.py
```

In Terminal 3

```c++
$ roslaunch fast_lio mapping_mid360_sim.launch
```

In Terminal 4

```c++
$ roslaunch ego_planner single_run_in_gazebo.launch
```

In Terminal 5

```c++
$ roslaunch ego_planner rviz.launch
```

In Terminal 6

If you have enabled the takeoff node in the **run_ctrl_gazebo.launch** file, you need to manually switch to **offboard mode** through **QGC** after unlocking the drone. If you disable the takeoff node, you can manually take off the drone through QGC and then plan.

```c++
$ roslaunch px4ctrl single_ctrl_in_gazebo.launch.launch
```

## 4.Real experiments

In Terminal 1

```c++
$ sudo chmod 777 /dev/ttyACM0
$ roslaunch mavros px4.launch
$ rosrun mavros mavcmd long 511 105 5000 0 0 0 0 0 & sleep 1
$ rosrun mavros mavcmd long 511 31 5000 0 0 0 0 0 & sleep 1
```

In Terminal 2

Before running the radar driver, you need to configure the radar network port and IP address

```
$ roslaunch livox_ros_driver2 msg_MID360.launch
```

In Terminal 3

```
$ roslaunch fast_lio mapping_mid360_exp.launch
```

In Terminal 4

```
$ roslaunch ego_planner single_run_in_exp.launch
```

In Terminal 5

```
$ roslaunch ego_planner rviz.launch
```

In Terminal 6

```
$ roslaunch px4ctrl single_ctrl_in_exp.launch
```

In Terminal 7

```c++
$ cd  {work_space}
$ sh shfiles/takeoff.sh
```

## 5.Reference Projects

[1.XTDrone](https://github.com/robin-shaun/XTDrone)

[2.Fast-Drone-250](https://github.com/ZJU-FAST-Lab/Fast-Drone-250/tree/master)

[3.Mid360_px4](https://github.com/qiurongcan/Mid360_px4)

[4.High_fast_lio2](https://github.com/HNU-CAT/high_fast_lio2)









