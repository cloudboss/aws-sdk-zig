/// A tag that is assigned to matching objects.
pub const AwsS3BucketBucketLifecycleConfigurationRulesFilterPredicateOperandsTagDetails = struct {
    /// The tag key.
    key: ?[]const u8 = null,

    /// The tag value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
