/// The key-value pair of properties for an event.
pub const Dimension = struct {
    /// The name of the dimension
    name: []const u8,

    /// The value of the dimension.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
