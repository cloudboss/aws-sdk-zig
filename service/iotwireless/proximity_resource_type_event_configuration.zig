const SidewalkResourceTypeEventConfiguration = @import("sidewalk_resource_type_event_configuration.zig").SidewalkResourceTypeEventConfiguration;

/// Proximity resource type event configuration object for enabling or disabling
/// topic.
pub const ProximityResourceTypeEventConfiguration = struct {
    /// Proximity resource type event configuration object for enabling and
    /// disabling wireless
    /// device topic.
    sidewalk: ?SidewalkResourceTypeEventConfiguration,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
    };
};
