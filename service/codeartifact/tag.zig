/// A tag is a key-value pair that can be used to manage, search for, or filter
/// resources in CodeArtifact.
pub const Tag = struct {
    /// The tag key.
    key: []const u8,

    /// The tag value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
