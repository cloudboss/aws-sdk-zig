/// Specifies a tag key, a tag value, or a tag key and value (as a pair) to use
/// in a tag-based condition that determines whether an S3 bucket is included or
/// excluded from a classification job. Tag keys and values are case sensitive.
/// Also, Amazon Macie doesn't support use of partial values or wildcard
/// characters in tag-based conditions.
pub const TagCriterionPairForJob = struct {
    /// The value for the tag key to use in the condition.
    key: ?[]const u8,

    /// The tag value to use in the condition.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
