/// Describes key/value pairs.
pub const Metadata = struct {
    /// The key name.
    name: ?[]const u8,

    /// The value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
