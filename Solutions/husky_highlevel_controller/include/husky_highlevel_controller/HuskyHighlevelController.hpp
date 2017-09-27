#pragma once

#include "husky_highlevel_controller/Algorithm.hpp"

#include <ros/ros.h>


namespace husky_highlevel_controller {

/*!
 * Class containing the Husky Highlevel Controller
 */
class HuskyHighlevelController {
public:
        /*!
         * Constructor.
         */
        HuskyHighlevelController(ros::NodeHandle& nodeHandle);

        /*!
         * Destructor.
         */
        virtual ~HuskyHighlevelController();

private:
        ros::NodeHandle nodeHandle_;
};

} /* namespace */
