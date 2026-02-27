/// A custom key-value pair associated with a resource such as a CloudTrail
/// trail, event data store, dashboard, or channel.
pub const Tag = struct {
    /// The key in a key-value pair. The key must be must be no longer than 128
    /// Unicode
    /// characters. The key must be unique for the resource to which it applies.
    key: []const u8,

    /// The value in a key-value pair of a tag. The value must be no longer than 256
    /// Unicode
    /// characters.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
