const PropagatingAttribute = @import("propagating_attribute.zig").PropagatingAttribute;

/// The configuration to add user-defined properties to enrich MQTT 5 messages.
pub const Mqtt5Configuration = struct {
    /// An object that represents the propagating thing attributes and the
    /// connection attributes.
    propagating_attributes: ?[]const PropagatingAttribute,

    pub const json_field_names = .{
        .propagating_attributes = "propagatingAttributes",
    };
};
