const FailoverType = @import("failover_type.zig").FailoverType;

/// Specifies routing configuration for user pool domains. Contains failover
/// settings for multi-region deployments.
pub const RoutingType = struct {
    /// The failover configuration that specifies the secondary region and health
    /// check settings.
    failover: ?FailoverType = null,

    pub const json_field_names = .{
        .failover = "Failover",
    };
};
