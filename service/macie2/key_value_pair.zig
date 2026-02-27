/// Provides information about the tags that are associated with an S3 bucket or
/// object. Each tag consists of a required tag key and an associated tag value.
pub const KeyValuePair = struct {
    /// One part of a key-value pair that comprises a tag. A tag key is a general
    /// label that acts as a category for more specific tag values.
    key: ?[]const u8,

    /// One part of a key-value pair that comprises a tag. A tag value acts as a
    /// descriptor for a tag key. A tag value can be an empty string.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
