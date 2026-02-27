const CustomerProfilesIntegrationConfig = @import("customer_profiles_integration_config.zig").CustomerProfilesIntegrationConfig;
const LambdaIntegrationConfig = @import("lambda_integration_config.zig").LambdaIntegrationConfig;
const QConnectIntegrationConfig = @import("q_connect_integration_config.zig").QConnectIntegrationConfig;

/// Integration config for Connect Instance
pub const IntegrationConfig = union(enum) {
    customer_profiles: ?CustomerProfilesIntegrationConfig,
    lambda: ?LambdaIntegrationConfig,
    q_connect: ?QConnectIntegrationConfig,

    pub const json_field_names = .{
        .customer_profiles = "customerProfiles",
        .lambda = "lambda",
        .q_connect = "qConnect",
    };
};
