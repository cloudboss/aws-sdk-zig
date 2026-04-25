const ServerlessConnectivityInfo = @import("serverless_connectivity_info.zig").ServerlessConnectivityInfo;
const VpcConnectionInfoServerless = @import("vpc_connection_info_serverless.zig").VpcConnectionInfoServerless;

/// Returns information about a serverless cluster operation.
pub const ClusterOperationV2Serverless = struct {
    /// Describes the cluster's attributes before any updates are applied. For
    /// example, networkType, which can be either IPv4 or DUAL.
    source_cluster_info: ?ServerlessConnectivityInfo = null,

    /// Describes the cluster's attributes after any updates are applied. For
    /// example, networkType, which can be either IPv4 or DUAL.
    target_cluster_info: ?ServerlessConnectivityInfo = null,

    /// Description of the VPC connection for CreateVpcConnection and
    /// DeleteVpcConnection operations.
    vpc_connection_info: ?VpcConnectionInfoServerless = null,

    pub const json_field_names = .{
        .source_cluster_info = "SourceClusterInfo",
        .target_cluster_info = "TargetClusterInfo",
        .vpc_connection_info = "VpcConnectionInfo",
    };
};
