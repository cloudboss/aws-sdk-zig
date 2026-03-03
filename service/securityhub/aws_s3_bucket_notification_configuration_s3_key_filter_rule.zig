const AwsS3BucketNotificationConfigurationS3KeyFilterRuleName = @import("aws_s3_bucket_notification_configuration_s3_key_filter_rule_name.zig").AwsS3BucketNotificationConfigurationS3KeyFilterRuleName;

/// Details for a filter rule.
pub const AwsS3BucketNotificationConfigurationS3KeyFilterRule = struct {
    /// Indicates whether the filter is based on the prefix or suffix of the Amazon
    /// S3 key.
    name: ?AwsS3BucketNotificationConfigurationS3KeyFilterRuleName = null,

    /// The filter value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
