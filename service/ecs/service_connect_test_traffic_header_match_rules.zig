/// The header matching rules for test traffic routing in Amazon ECS blue/green
/// deployments.
/// These rules determine how incoming requests are matched based on HTTP
/// headers to route test
/// traffic to the new service revision.
pub const ServiceConnectTestTrafficHeaderMatchRules = struct {
    /// The exact value that the HTTP header must match for the test traffic routing
    /// rule to apply. This provides precise control over which requests are routed
    /// to the new service revision during blue/green deployments.
    exact: []const u8,

    pub const json_field_names = .{
        .exact = "exact",
    };
};
