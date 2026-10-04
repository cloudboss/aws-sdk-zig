/// Specifies failover configuration for multi-region user pool domains.
/// Contains settings for the secondary region and health check configuration.
pub const FailoverType = struct {
    /// The ID of the Amazon Web Services Route53 healthcheck that controls routing.
    /// If the healthcheck is healthy,
    /// traffic will be routed to the primary replica, and if the healthcheck is
    /// unhealthy,
    /// traffic will be routed to the secondary region.
    primary_route_53_health_check_id: []const u8,

    /// The secondary Amazon Web Services Region to use for failover when the
    /// primary region becomes unavailable.
    secondary_region: []const u8,

    pub const json_field_names = .{
        .primary_route_53_health_check_id = "PrimaryRoute53HealthCheckId",
        .secondary_region = "SecondaryRegion",
    };
};
