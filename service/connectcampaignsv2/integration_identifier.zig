const CustomerProfilesIntegrationIdentifier = @import("customer_profiles_integration_identifier.zig").CustomerProfilesIntegrationIdentifier;
const LambdaIntegrationIdentifier = @import("lambda_integration_identifier.zig").LambdaIntegrationIdentifier;
const QConnectIntegrationIdentifier = @import("q_connect_integration_identifier.zig").QConnectIntegrationIdentifier;

/// Integration identifier for Connect instance
pub const IntegrationIdentifier = union(enum) {
    customer_profiles: ?CustomerProfilesIntegrationIdentifier,
    lambda: ?LambdaIntegrationIdentifier,
    q_connect: ?QConnectIntegrationIdentifier,

    pub const json_field_names = .{
        .customer_profiles = "customerProfiles",
        .lambda = "lambda",
        .q_connect = "qConnect",
    };
};
