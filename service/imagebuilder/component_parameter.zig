/// Contains a key/value pair that sets the named component parameter.
pub const ComponentParameter = struct {
    /// The name of the component parameter to set.
    name: []const u8,

    /// Sets the value for the named component parameter.
    value: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
