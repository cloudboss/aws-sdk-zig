/// A key-value pair object.
pub const KeyValuePair = struct {
    /// The name of the key-value pair. For environment variables, this is the name
    /// of the environment variable.
    name: ?[]const u8 = null,

    /// The value of the key-value pair. For environment variables, this is the
    /// value of the environment variable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
