const SchedulerResourceStatus = @import("scheduler_resource_status.zig").SchedulerResourceStatus;

/// Summary of the cluster policy.
pub const ClusterSchedulerConfigSummary = struct {
    /// ARN of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// ARN of the cluster policy.
    cluster_scheduler_config_arn: []const u8,

    /// ID of the cluster policy.
    cluster_scheduler_config_id: []const u8,

    /// Version of the cluster policy.
    cluster_scheduler_config_version: ?i32 = null,

    /// Creation time of the cluster policy.
    creation_time: i64,

    /// Last modified time of the cluster policy.
    last_modified_time: ?i64 = null,

    /// Name of the cluster policy.
    name: []const u8,

    /// Status of the cluster policy.
    status: SchedulerResourceStatus,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_scheduler_config_arn = "ClusterSchedulerConfigArn",
        .cluster_scheduler_config_id = "ClusterSchedulerConfigId",
        .cluster_scheduler_config_version = "ClusterSchedulerConfigVersion",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
    };
};
