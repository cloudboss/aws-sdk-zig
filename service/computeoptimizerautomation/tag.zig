/// A key-value pair used to categorize and organize Amazon Web Services
/// resources and automation rules.
pub const Tag = struct {
    /// The tag key, which can be up to 128 characters long.
    key: []const u8,

    /// The tag value, which can be up to 256 characters long.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
