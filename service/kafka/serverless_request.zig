const ServerlessClientAuthentication = @import("serverless_client_authentication.zig").ServerlessClientAuthentication;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Serverless cluster request.
pub const ServerlessRequest = struct {
    /// Includes all client authentication information.
    client_authentication: ?ServerlessClientAuthentication,

    /// The configuration of the Amazon VPCs for the cluster.
    vpc_configs: []const VpcConfig,

    pub const json_field_names = .{
        .client_authentication = "ClientAuthentication",
        .vpc_configs = "VpcConfigs",
    };
};
