/// Tag for the Profile.
pub const Tag = struct {
    /// Key associated with the `Tag`.
    key: []const u8,

    /// Value for the Tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
