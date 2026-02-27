/// A set of key-value pairs that are used to manage the resource. Tags can only
/// be applied to permission sets and cannot be applied to corresponding roles
/// that IAM Identity Center creates in Amazon Web Services accounts.
pub const Tag = struct {
    /// The key for the tag.
    key: []const u8,

    /// The value of the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
