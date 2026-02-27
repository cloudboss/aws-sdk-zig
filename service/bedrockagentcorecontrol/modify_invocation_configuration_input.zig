/// The configuration for updating invocation settings.
pub const ModifyInvocationConfigurationInput = struct {
    /// The updated S3 bucket name for event payload delivery.
    payload_delivery_bucket_name: ?[]const u8,

    /// The updated ARN of the SNS topic for job notifications.
    topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .payload_delivery_bucket_name = "payloadDeliveryBucketName",
        .topic_arn = "topicArn",
    };
};
