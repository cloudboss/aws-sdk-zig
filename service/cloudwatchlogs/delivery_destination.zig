const aws = @import("aws");

const DeliveryDestinationConfiguration = @import("delivery_destination_configuration.zig").DeliveryDestinationConfiguration;
const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;
const OutputFormat = @import("output_format.zig").OutputFormat;

/// This structure contains information about one *delivery destination* in
/// your account. A delivery destination is an Amazon Web Services resource that
/// represents an
/// Amazon Web Services service that logs can be sent to. CloudWatch Logs,
/// Amazon S3,
/// Firehose, and X-Ray are supported as delivery destinations.
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
/// represents the actual delivery destination.
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
pub const DeliveryDestination = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies this delivery
    /// destination.
    arn: ?[]const u8 = null,

    /// A structure that contains the ARN of the Amazon Web Services resource that
    /// will receive the
    /// logs.
    delivery_destination_configuration: ?DeliveryDestinationConfiguration = null,

    /// Displays whether this delivery destination is CloudWatch Logs, Amazon S3,
    /// Firehose, or X-Ray.
    delivery_destination_type: ?DeliveryDestinationType = null,

    /// The name of this delivery destination.
    name: ?[]const u8 = null,

    /// The format of the logs that are sent to this delivery destination.
    output_format: ?OutputFormat = null,

    /// The tags that have been assigned to this delivery destination.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .delivery_destination_configuration = "deliveryDestinationConfiguration",
        .delivery_destination_type = "deliveryDestinationType",
        .name = "name",
        .output_format = "outputFormat",
        .tags = "tags",
    };
};
