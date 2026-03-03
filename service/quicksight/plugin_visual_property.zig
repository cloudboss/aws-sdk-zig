/// The key value pair of the persisted property.
pub const PluginVisualProperty = struct {
    /// The name of the plugin visual property.
    name: ?[]const u8 = null,

    /// The value of the plugin visual property.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
