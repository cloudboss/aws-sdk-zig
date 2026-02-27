const AwsS3BucketNotificationConfigurationS3KeyFilter = @import("aws_s3_bucket_notification_configuration_s3_key_filter.zig").AwsS3BucketNotificationConfigurationS3KeyFilter;

/// Filtering information for the notifications. The
/// filtering is based on Amazon S3 key names.
pub const AwsS3BucketNotificationConfigurationFilter = struct {
    /// Details for an Amazon S3 filter.
    s3_key_filter: ?AwsS3BucketNotificationConfigurationS3KeyFilter,

    pub const json_field_names = .{
        .s3_key_filter = "S3KeyFilter",
    };
};
