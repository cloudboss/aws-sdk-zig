/// An object that represents the connection attribute, thing attribute, and the
/// user property key.
pub const PropagatingAttribute = struct {
    /// The attribute associated with the connection between a device and Amazon Web
    /// Services IoT Core.
    connection_attribute: ?[]const u8,

    /// The user-defined thing attribute that is propagating for MQTT 5 message
    /// enrichment.
    thing_attribute: ?[]const u8,

    /// The key of the user property key-value pair.
    user_property_key: ?[]const u8,

    pub const json_field_names = .{
        .connection_attribute = "connectionAttribute",
        .thing_attribute = "thingAttribute",
        .user_property_key = "userPropertyKey",
    };
};
