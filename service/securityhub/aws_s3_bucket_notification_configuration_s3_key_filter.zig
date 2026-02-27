const AwsS3BucketNotificationConfigurationS3KeyFilterRule = @import("aws_s3_bucket_notification_configuration_s3_key_filter_rule.zig").AwsS3BucketNotificationConfigurationS3KeyFilterRule;

/// Details for an Amazon S3 filter.
pub const AwsS3BucketNotificationConfigurationS3KeyFilter = struct {
    /// The filter rules for the filter.
    filter_rules: ?[]const AwsS3BucketNotificationConfigurationS3KeyFilterRule,

    pub const json_field_names = .{
        .filter_rules = "FilterRules",
    };
};
