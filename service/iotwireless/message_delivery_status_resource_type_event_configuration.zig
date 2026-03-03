const SidewalkResourceTypeEventConfiguration = @import("sidewalk_resource_type_event_configuration.zig").SidewalkResourceTypeEventConfiguration;

/// Message delivery status resource type event configuration object for
/// enabling or
/// disabling relevant topic.
pub const MessageDeliveryStatusResourceTypeEventConfiguration = struct {
    sidewalk: ?SidewalkResourceTypeEventConfiguration = null,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
    };
};
