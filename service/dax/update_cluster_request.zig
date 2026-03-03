pub const UpdateClusterRequest = struct {
    /// The name of the DAX cluster to be modified.
    cluster_name: []const u8,

    /// A description of the changes being made to the cluster.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the topic.
    notification_topic_arn: ?[]const u8 = null,

    /// The current state of the topic. A value of “active” means that notifications
    /// will
    /// be sent to the topic. A value of “inactive” means that notifications will
    /// not be sent to
    /// the topic.
    notification_topic_status: ?[]const u8 = null,

    /// The name of a parameter group for this cluster.
    parameter_group_name: ?[]const u8 = null,

    /// A range of time when maintenance of DAX cluster software will be performed.
    /// For
    /// example: `sun:01:00-sun:09:00`. Cluster maintenance normally takes less than
    /// 30 minutes, and is performed automatically within the maintenance window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// A list of user-specified security group IDs to be assigned to each node in
    /// the DAX
    /// cluster. If this parameter is not specified, DAX assigns the default VPC
    /// security group
    /// to each node.
    security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .description = "Description",
        .notification_topic_arn = "NotificationTopicArn",
        .notification_topic_status = "NotificationTopicStatus",
        .parameter_group_name = "ParameterGroupName",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .security_group_ids = "SecurityGroupIds",
    };
};
