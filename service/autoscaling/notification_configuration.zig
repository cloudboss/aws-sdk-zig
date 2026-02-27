/// Describes a notification.
pub const NotificationConfiguration = struct {
    /// The name of the Auto Scaling group.
    auto_scaling_group_name: ?[]const u8,

    /// One of the following event notification types:
    ///
    /// * `autoscaling:EC2_INSTANCE_LAUNCH`
    ///
    /// * `autoscaling:EC2_INSTANCE_LAUNCH_ERROR`
    ///
    /// * `autoscaling:EC2_INSTANCE_TERMINATE`
    ///
    /// * `autoscaling:EC2_INSTANCE_TERMINATE_ERROR`
    ///
    /// * `autoscaling:TEST_NOTIFICATION`
    notification_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic.
    topic_arn: ?[]const u8,
};
