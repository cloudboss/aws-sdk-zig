const ServerlessClientAuthentication = @import("serverless_client_authentication.zig").ServerlessClientAuthentication;
const ServerlessConnectivityInfo = @import("serverless_connectivity_info.zig").ServerlessConnectivityInfo;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Serverless cluster.
pub const Serverless = struct {
    /// Includes all client authentication information.
    client_authentication: ?ServerlessClientAuthentication = null,

    /// Describes the cluster's connectivity information, such as its network type,
    /// which is IPv4 or DUAL.
    connectivity_info: ?ServerlessConnectivityInfo = null,

    /// The configuration of the Amazon VPCs for the cluster.
    vpc_configs: []const VpcConfig,

    pub const json_field_names = .{
        .client_authentication = "ClientAuthentication",
        .connectivity_info = "ConnectivityInfo",
        .vpc_configs = "VpcConfigs",
    };
};
