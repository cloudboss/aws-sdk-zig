/// An arbitary key/value pair used to add searchable metadata to secure tunnel
/// resources.
pub const Tag = struct {
    /// The key of the tag.
    key: []const u8,

    /// The value of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
