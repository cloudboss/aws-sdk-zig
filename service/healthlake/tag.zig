/// A label consisting of a user-defined key and value. The form for tags is
/// {"Key",
/// "Value"}
pub const Tag = struct {
    /// The key portion of a tag. Tag keys are case sensitive.
    key: []const u8,

    /// The value portion of a tag. Tag values are case-sensitive.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
