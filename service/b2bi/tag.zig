/// Creates a key-value pair for a specific resource. Tags are metadata that you
/// can use to search for and group a resource for various purposes. You can
/// apply tags to capabilities, partnerships, profiles and transformers. A tag
/// key can take more than one value. For example, to group capabilities for
/// accounting purposes, you might create a tag called `Group` and assign the
/// values `Research` and `Accounting` to that group.
pub const Tag = struct {
    /// Specifies the name assigned to the tag that you create.
    key: []const u8,

    /// Contains one or more values that you assigned to the key name that you
    /// create.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
