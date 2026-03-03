const ClusterType = @import("cluster_type.zig").ClusterType;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const ClusterOperationV2Provisioned = @import("cluster_operation_v2_provisioned.zig").ClusterOperationV2Provisioned;
const ClusterOperationV2Serverless = @import("cluster_operation_v2_serverless.zig").ClusterOperationV2Serverless;

/// Returns information about a cluster operation.
pub const ClusterOperationV2 = struct {
    /// ARN of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// Type of the backend cluster.
    cluster_type: ?ClusterType = null,

    /// The time at which the operation finished.
    end_time: ?i64 = null,

    /// If cluster operation failed from an error, it describes the error.
    error_info: ?ErrorInfo = null,

    /// ARN of the cluster operation.
    operation_arn: ?[]const u8 = null,

    /// State of the cluster operation.
    operation_state: ?[]const u8 = null,

    /// Type of the cluster operation.
    operation_type: ?[]const u8 = null,

    /// Properties of a provisioned cluster.
    provisioned: ?ClusterOperationV2Provisioned = null,

    /// Properties of a serverless cluster.
    serverless: ?ClusterOperationV2Serverless = null,

    /// The time at which operation was started.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .cluster_type = "ClusterType",
        .end_time = "EndTime",
        .error_info = "ErrorInfo",
        .operation_arn = "OperationArn",
        .operation_state = "OperationState",
        .operation_type = "OperationType",
        .provisioned = "Provisioned",
        .serverless = "Serverless",
        .start_time = "StartTime",
    };
};
