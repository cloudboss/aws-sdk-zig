/// A key/value pair that grants users access to meeting resources.
pub const Tag = struct {
    /// The key half of a tag.
    key: []const u8,

    /// The value half of a tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
