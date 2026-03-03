const AwsS3BucketNotificationConfigurationFilter = @import("aws_s3_bucket_notification_configuration_filter.zig").AwsS3BucketNotificationConfigurationFilter;

/// Details for an S3 bucket notification configuration.
pub const AwsS3BucketNotificationConfigurationDetail = struct {
    /// The ARN of the Lambda function, Amazon SQS queue, or Amazon SNS topic that
    /// generates the
    /// notification.
    destination: ?[]const u8 = null,

    /// The list of events that trigger a notification.
    events: ?[]const []const u8 = null,

    /// The filters that determine which S3 buckets generate notifications.
    filter: ?AwsS3BucketNotificationConfigurationFilter = null,

    /// Indicates the type of notification. Notifications can be generated using
    /// Lambda functions,
    /// Amazon SQS queues, or Amazon SNS topics, with corresponding valid values as
    /// follows:
    ///
    /// * `LambdaConfiguration`
    ///
    /// * `QueueConfiguration`
    ///
    /// * `TopicConfiguration`
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .events = "Events",
        .filter = "Filter",
        .@"type" = "Type",
    };
};
