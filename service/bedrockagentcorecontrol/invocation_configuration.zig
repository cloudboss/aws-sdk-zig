/// The configuration to invoke a self-managed memory processing pipeline with.
pub const InvocationConfiguration = struct {
    /// The S3 bucket name for event payload delivery.
    payload_delivery_bucket_name: []const u8,

    /// The ARN of the SNS topic for job notifications.
    topic_arn: []const u8,

    pub const json_field_names = .{
        .payload_delivery_bucket_name = "payloadDeliveryBucketName",
        .topic_arn = "topicArn",
    };
};
