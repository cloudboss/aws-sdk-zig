/// A tag filter.
pub const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateTagDetails = struct {
    /// The tag key.
    key: ?[]const u8,

    /// The tag value
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
