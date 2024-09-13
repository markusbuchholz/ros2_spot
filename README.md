# ROS 2 Boston Dynamics Spot 

![image](https://github.com/user-attachments/assets/3bb7a3d7-fbf9-4ed2-bac7-d6a40c27007b)

The following repository ROS 2 environment to run Spot robot.

## Build


```bash

sudo ./build.sh

```


## Run

```bash

sudo ./run.sh

```

```bash
cd colcon_ws

mkdir src && cd src

git clone https://github.com/bdaiinstitute/spot_ros2.git

cd spot_ros2

git submodule init

git submodule update

./install_spot_ros2.sh

cd ../..

colcon build --symlink-install --packages-ignore proto2ros_tests

source install/setup.bash

```

## Simulate robots

```bash
ros2 launch spot_ros2_control noarm_squat.launch.py

or

ros2 launch spot_ros2_control wiggle_arm.launch.py

```


## References
- [Boston Dynamics AI Institute - Spot](https://github.com/bdaiinstitute/spot_ros2)
