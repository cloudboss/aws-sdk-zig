/// Specifies a tag key or tag key and value pair to use in a tag-based
/// condition that determines whether an S3 object is included or excluded from
/// a classification job. Tag keys and values are case sensitive. Also, Amazon
/// Macie doesn't support use of partial values or wildcard characters in
/// tag-based conditions.
pub const TagValuePair = struct {
    /// The value for the tag key to use in the condition.
    key: ?[]const u8 = null,

    /// The tag value, associated with the specified tag key (key), to use in the
    /// condition. To specify only a tag key for a condition, specify the tag key
    /// for the key property and set this value to an empty string.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
