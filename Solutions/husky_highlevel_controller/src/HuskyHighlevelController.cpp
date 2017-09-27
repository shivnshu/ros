#include "husky_highlevel_controller/HuskyHighlevelController.hpp"
#include <string>

namespace husky_highlevel_controller {

HuskyHighlevelController::HuskyHighlevelController(ros::NodeHandle& nodeHandle) :
  nodeHandle_(nodeHandle)
{
    if (!nodeHandle_.getParam("topic", topic_) || !nodeHandle_.getParam("queue_size", queue_size_)) {
        ROS_ERROR("Could not read parameters");
        ros::requestShutdown();
    }
    subscriber_ = nodeHandle_.subscribe("/scan", queue_size_, &HuskyHighlevelController.topicCallback, this);
    service_server_ = nodeHandle_.advertiseService(topic_, &HuskyHighlevelController.serviceCallback, this);
    ROS_INFO("Successfully launched node");
}

HuskyHighlevelController::~HuskyHighlevelController()
{
}

void HuskyHighlevelController::topicCallback(const sensor_msgs::LaserScan& message)
{
    algorithm_.putData(message.ranges);
}
bool HuskyHighlevelController::serviceCallback(std_srvs::Trigger::Request& request, std_srvs::Trigger::Response& response)
{
    response.success = true;
    response.message = "Min distance is " + std::to_string(algorithm_.getMin());
    return true;
}

} /* namespace */
