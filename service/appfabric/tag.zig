/// The key or keys of the key-value pairs for the tag or tags assigned to a
/// resource.
pub const Tag = struct {
    /// Tag key.
    key: []const u8,

    /// Tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
