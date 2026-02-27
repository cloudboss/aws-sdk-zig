const FailoverConfig = @import("failover_config.zig").FailoverConfig;

/// The routing configuration of the endpoint.
pub const RoutingConfig = struct {
    /// The failover configuration for an endpoint. This includes what triggers
    /// failover and what
    /// happens when it's triggered.
    failover_config: FailoverConfig,

    pub const json_field_names = .{
        .failover_config = "FailoverConfig",
    };
};
