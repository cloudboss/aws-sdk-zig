const ClusterOperationStep = @import("cluster_operation_step.zig").ClusterOperationStep;
const MutableClusterInfo = @import("mutable_cluster_info.zig").MutableClusterInfo;
const VpcConnectionInfo = @import("vpc_connection_info.zig").VpcConnectionInfo;

/// Returns information about a provisioned cluster operation.
pub const ClusterOperationV2Provisioned = struct {
    /// Steps completed during the operation.
    operation_steps: ?[]const ClusterOperationStep,

    /// Information about cluster attributes before a cluster is updated.
    source_cluster_info: ?MutableClusterInfo,

    /// Information about cluster attributes after a cluster is updated.
    target_cluster_info: ?MutableClusterInfo,

    /// Description of the VPC connection for CreateVpcConnection and
    /// DeleteVpcConnection operations.
    vpc_connection_info: ?VpcConnectionInfo,

    pub const json_field_names = .{
        .operation_steps = "OperationSteps",
        .source_cluster_info = "SourceClusterInfo",
        .target_cluster_info = "TargetClusterInfo",
        .vpc_connection_info = "VpcConnectionInfo",
    };
};
