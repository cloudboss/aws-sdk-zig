/// The key or keys of the key-value pairs for the resource tag or tags assigned
/// to the
/// resource.
pub const Tag = struct {
    /// Tag key.
    key: []const u8,

    /// Tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
