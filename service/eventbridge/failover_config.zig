const Primary = @import("primary.zig").Primary;
const Secondary = @import("secondary.zig").Secondary;

/// The failover configuration for an endpoint. This includes what triggers
/// failover and what
/// happens when it's triggered.
pub const FailoverConfig = struct {
    /// The main Region of the endpoint.
    primary: Primary,

    /// The Region that events are routed to when failover is triggered or event
    /// replication is
    /// enabled.
    secondary: Secondary,

    pub const json_field_names = .{
        .primary = "Primary",
        .secondary = "Secondary",
    };
};
