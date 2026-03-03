const AgentDetails = @import("agent_details.zig").AgentDetails;
const ManagementType = @import("management_type.zig").ManagementType;

/// Contains information about the Amazon EC2 instance runtime
/// coverage details.
pub const CoverageEc2InstanceDetails = struct {
    /// Information about the installed security agent.
    agent_details: ?AgentDetails = null,

    /// The cluster ARN of the Amazon ECS cluster running on
    /// the Amazon EC2 instance.
    cluster_arn: ?[]const u8 = null,

    /// The Amazon EC2 instance ID.
    instance_id: ?[]const u8 = null,

    /// The instance type of the Amazon EC2 instance.
    instance_type: ?[]const u8 = null,

    /// Indicates how the GuardDuty security agent is managed for this resource.
    ///
    /// * `AUTO_MANAGED` indicates that GuardDuty deploys and manages updates for
    ///   this resource.
    ///
    /// * `MANUAL` indicates that you are responsible to deploy, update, and manage
    ///   the GuardDuty
    /// security agent updates for this resource.
    ///
    /// The `DISABLED` status doesn't apply to Amazon
    /// EC2 instances and Amazon EKS clusters.
    management_type: ?ManagementType = null,

    pub const json_field_names = .{
        .agent_details = "AgentDetails",
        .cluster_arn = "ClusterArn",
        .instance_id = "InstanceId",
        .instance_type = "InstanceType",
        .management_type = "ManagementType",
    };
};
