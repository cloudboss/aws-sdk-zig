const ClusterType = @import("cluster_type.zig").ClusterType;

/// Returns information about a cluster operation.
pub const ClusterOperationV2Summary = struct {
    /// ARN of the cluster.
    cluster_arn: ?[]const u8,

    /// Type of the backend cluster.
    cluster_type: ?ClusterType,

    /// The time at which the operation finished.
    end_time: ?i64,

    /// ARN of the cluster operation.
    operation_arn: ?[]const u8,

    /// State of the cluster operation.
    operation_state: ?[]const u8,

    /// Type of the cluster operation.
    operation_type: ?[]const u8,

    /// The time at which operation was started.
    start_time: ?i64,

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
