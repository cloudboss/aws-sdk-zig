const ErrorInfo = @import("error_info.zig").ErrorInfo;
const ClusterOperationStep = @import("cluster_operation_step.zig").ClusterOperationStep;
const MutableClusterInfo = @import("mutable_cluster_info.zig").MutableClusterInfo;
const VpcConnectionInfo = @import("vpc_connection_info.zig").VpcConnectionInfo;

/// Returns information about a cluster operation.
pub const ClusterOperationInfo = struct {
    /// The ID of the API request that triggered this operation.
    client_request_id: ?[]const u8,

    /// ARN of the cluster.
    cluster_arn: ?[]const u8,

    /// The time that the operation was created.
    creation_time: ?i64,

    /// The time at which the operation finished.
    end_time: ?i64,

    /// Describes the error if the operation fails.
    error_info: ?ErrorInfo,

    /// ARN of the cluster operation.
    operation_arn: ?[]const u8,

    /// State of the cluster operation.
    operation_state: ?[]const u8,

    /// Steps completed during the operation.
    operation_steps: ?[]const ClusterOperationStep,

    /// Type of the cluster operation.
    operation_type: ?[]const u8,

    /// Information about cluster attributes before a cluster is updated.
    source_cluster_info: ?MutableClusterInfo,

    /// Information about cluster attributes after a cluster is updated.
    target_cluster_info: ?MutableClusterInfo,

    /// Description of the VPC connection for CreateVpcConnection and
    /// DeleteVpcConnection operations.
    vpc_connection_info: ?VpcConnectionInfo,

    pub const json_field_names = .{
        .client_request_id = "ClientRequestId",
        .cluster_arn = "ClusterArn",
        .creation_time = "CreationTime",
        .end_time = "EndTime",
        .error_info = "ErrorInfo",
        .operation_arn = "OperationArn",
        .operation_state = "OperationState",
        .operation_steps = "OperationSteps",
        .operation_type = "OperationType",
        .source_cluster_info = "SourceClusterInfo",
        .target_cluster_info = "TargetClusterInfo",
        .vpc_connection_info = "VpcConnectionInfo",
    };
};
