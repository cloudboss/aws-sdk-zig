const SidewalkResourceTypeEventConfiguration = @import("sidewalk_resource_type_event_configuration.zig").SidewalkResourceTypeEventConfiguration;

/// Device registration state resource type event configuration object for
/// enabling or
/// disabling topic.
pub const DeviceRegistrationStateResourceTypeEventConfiguration = struct {
    /// Device registration resource type state event configuration object for
    /// enabling or
    /// disabling Sidewalk related event topics.
    sidewalk: ?SidewalkResourceTypeEventConfiguration,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
    };
};
