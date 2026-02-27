/// Represents a named directory attribute.
pub const Attribute = struct {
    /// The name of the attribute.
    name: ?[]const u8,

    /// The value of the attribute.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
