const aws = @import("aws");

/// This structure contains information about one *delivery source* in your
/// account. A delivery source is an Amazon Web Services resource that sends
/// logs to an Amazon Web Services destination. The destination can be
/// CloudWatch Logs, Amazon S3, or
/// Firehose.
///
/// Only some Amazon Web Services services support being configured as a
/// delivery source. These
/// services are listed as **Supported [V2 Permissions]** in the
/// table at [Enabling logging from
/// Amazon Web Services
/// services.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-and-resource-policy.html)
///
/// To configure logs delivery between a supported Amazon Web Services service
/// and a
/// destination, you must do the following:
///
/// * Create a delivery source, which is a logical object that represents the
///   resource that
/// is actually sending the logs. For more information, see
/// [PutDeliverySource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliverySource.html).
///
/// * Create a *delivery destination*, which is a logical object that
/// represents the actual delivery destination. For more information, see
/// [PutDeliveryDestination](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestination.html).
///
/// * If you are delivering logs cross-account, you must use
///   [PutDeliveryDestinationPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDeliveryDestinationPolicy.html) in the destination account to assign an IAM policy to the destination. This policy allows delivery to that destination.
///
/// * Create a *delivery* by pairing exactly one delivery source and one
/// delivery destination. For more information, see
/// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
///
/// You can configure a single delivery source to send logs to multiple
/// destinations by
/// creating multiple deliveries. You can also create multiple deliveries to
/// configure multiple
/// delivery sources to send logs to the same delivery destination.
pub const DeliverySource = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies this delivery
    /// source.
    arn: ?[]const u8 = null,

    /// The type of log that the source is sending. For valid values for this
    /// parameter, see the
    /// documentation for the source service.
    log_type: ?[]const u8 = null,

    /// The unique name of the delivery source.
    name: ?[]const u8 = null,

    /// This array contains the ARN of the Amazon Web Services resource that sends
    /// logs and is
    /// represented by this delivery source. Currently, only one ARN can be in the
    /// array.
    resource_arns: ?[]const []const u8 = null,

    /// The Amazon Web Services service that is sending logs.
    service: ?[]const u8 = null,

    /// The tags that have been assigned to this delivery source.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .log_type = "logType",
        .name = "name",
        .resource_arns = "resourceArns",
        .service = "service",
        .tags = "tags",
    };
};
