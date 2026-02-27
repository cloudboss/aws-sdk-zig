/// Creates a key-value pair for a specific resource. Tags are metadata that you
/// can use to search for and group a resource for various purposes. You can
/// apply tags to servers, users, and roles. A tag key can take more than one
/// value. For example, to group servers for accounting purposes, you might
/// create a tag called `Group` and assign the values `Research` and
/// `Accounting` to that group.
pub const Tag = struct {
    /// The name assigned to the tag that you create.
    key: []const u8,

    /// Contains one or more values that you assigned to the key name you create.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
