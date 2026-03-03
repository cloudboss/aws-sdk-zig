const ClusterType = @import("cluster_type.zig").ClusterType;

/// Returns information about a cluster operation.
pub const ClusterOperationV2Summary = struct {
    /// ARN of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// Type of the backend cluster.
    cluster_type: ?ClusterType = null,

    /// The time at which the operation finished.
    end_time: ?i64 = null,

    /// ARN of the cluster operation.
    operation_arn: ?[]const u8 = null,

    /// State of the cluster operation.
    operation_state: ?[]const u8 = null,

    /// Type of the cluster operation.
    operation_type: ?[]const u8 = null,

    /// The time at which operation was started.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_type = "ClusterType",
        .end_time = "EndTime",
        .operation_arn = "OperationArn",
        .operation_state = "OperationState",
        .operation_type = "OperationType",
        .start_time = "StartTime",
    };
};
