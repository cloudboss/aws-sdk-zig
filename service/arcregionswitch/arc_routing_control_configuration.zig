const aws = @import("aws");

const ArcRoutingControlState = @import("arc_routing_control_state.zig").ArcRoutingControlState;

/// Configuration for ARC routing controls used in a Region switch plan. Routing
/// controls are simple on/off switches that you can use to shift traffic away
/// from an impaired Region.
pub const ArcRoutingControlConfiguration = struct {
    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8,

    /// The Region and ARC routing controls for the configuration.
    region_and_routing_controls: []const aws.map.MapEntry([]const ArcRoutingControlState),

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    pub const json_field_names = .{
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .region_and_routing_controls = "regionAndRoutingControls",
        .timeout_minutes = "timeoutMinutes",
    };
};
