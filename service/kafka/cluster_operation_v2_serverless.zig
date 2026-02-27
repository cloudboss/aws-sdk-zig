const VpcConnectionInfoServerless = @import("vpc_connection_info_serverless.zig").VpcConnectionInfoServerless;

/// Returns information about a serverless cluster operation.
pub const ClusterOperationV2Serverless = struct {
    /// Description of the VPC connection for CreateVpcConnection and
    /// DeleteVpcConnection operations.
    vpc_connection_info: ?VpcConnectionInfoServerless,

    pub const json_field_names = .{
        .vpc_connection_info = "VpcConnectionInfo",
    };
};
