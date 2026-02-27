const AwsS3BucketNotificationConfigurationDetail = @import("aws_s3_bucket_notification_configuration_detail.zig").AwsS3BucketNotificationConfigurationDetail;

/// The notification
/// configuration for the S3 bucket.
pub const AwsS3BucketNotificationConfiguration = struct {
    /// Configurations for S3 bucket notifications.
    configurations: ?[]const AwsS3BucketNotificationConfigurationDetail,

    pub const json_field_names = .{
        .configurations = "Configurations",
    };
};
