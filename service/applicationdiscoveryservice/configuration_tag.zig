const ConfigurationItemType = @import("configuration_item_type.zig").ConfigurationItemType;

/// Tags for a configuration item. Tags are metadata that help you categorize IT
/// assets.
pub const ConfigurationTag = struct {
    /// The configuration ID for the item to tag. You can specify a list of keys and
    /// values.
    configuration_id: ?[]const u8,

    /// A type of IT asset to tag.
    configuration_type: ?ConfigurationItemType,

    /// A type of tag on which to filter. For example,
    /// *serverType*.
    key: ?[]const u8,

    /// The time the configuration tag was created in Coordinated Universal Time
    /// (UTC).
    time_of_creation: ?i64,

    /// A value on which to filter. For example *key = serverType* and
    /// *value = web server*.
    value: ?[]const u8,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
        .configuration_type = "configurationType",
        .key = "key",
        .time_of_creation = "timeOfCreation",
        .value = "value",
    };
};
