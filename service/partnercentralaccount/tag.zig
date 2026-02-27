/// A key-value pair used to associate metadata with AWS Partner Central Account
/// resources.
pub const Tag = struct {
    /// The key name of the tag. Tag keys are case-sensitive.
    key: []const u8,

    /// The value associated with the tag key. Tag values are case-sensitive.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
