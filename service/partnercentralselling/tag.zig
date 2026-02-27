/// The key-value pair assigned to a specified resource.
pub const Tag = struct {
    /// The key in the tag.
    key: []const u8,

    /// The value in the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
