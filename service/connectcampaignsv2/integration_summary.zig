const CustomerProfilesIntegrationSummary = @import("customer_profiles_integration_summary.zig").CustomerProfilesIntegrationSummary;
const LambdaIntegrationSummary = @import("lambda_integration_summary.zig").LambdaIntegrationSummary;
const QConnectIntegrationSummary = @import("q_connect_integration_summary.zig").QConnectIntegrationSummary;

/// Integration summary for Connect instance.
pub const IntegrationSummary = union(enum) {
    customer_profiles: ?CustomerProfilesIntegrationSummary,
    lambda: ?LambdaIntegrationSummary,
    q_connect: ?QConnectIntegrationSummary,

    pub const json_field_names = .{
        .customer_profiles = "customerProfiles",
        .lambda = "lambda",
        .q_connect = "qConnect",
    };
};
