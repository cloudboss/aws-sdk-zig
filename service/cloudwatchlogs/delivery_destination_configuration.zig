/// A structure that contains information about one logs delivery destination.
pub const DeliveryDestinationConfiguration = struct {
    /// The ARN of the Amazon Web Services destination that this delivery
    /// destination represents.
    /// That Amazon Web Services destination can be a log group in CloudWatch Logs,
    /// an Amazon S3 bucket, or a delivery stream in Firehose.
    destination_resource_arn: []const u8,

    pub const json_field_names = .{
        .destination_resource_arn = "destinationResourceArn",
    };
};
