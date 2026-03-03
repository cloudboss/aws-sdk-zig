const aws = @import("aws");

const DeliveryDestinationType = @import("delivery_destination_type.zig").DeliveryDestinationType;
const S3DeliveryConfiguration = @import("s3_delivery_configuration.zig").S3DeliveryConfiguration;

/// This structure contains information about one *delivery* in your
/// account.
///
/// A delivery is a connection between a logical *delivery source* and a
/// logical *delivery destination*.
///
/// For more information, see
/// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html).
///
/// To update an existing delivery configuration, use
/// [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html).
pub const Delivery = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies this delivery.
    arn: ?[]const u8 = null,

    /// The ARN of the delivery destination that is associated with this delivery.
    delivery_destination_arn: ?[]const u8 = null,

    /// Displays whether the delivery destination associated with this delivery is
    /// CloudWatch Logs, Amazon S3, Firehose, or X-Ray.
    delivery_destination_type: ?DeliveryDestinationType = null,

    /// The name of the delivery source that is associated with this delivery.
    delivery_source_name: ?[]const u8 = null,

    /// The field delimiter that is used between record fields when the final output
    /// format of a
    /// delivery is in `Plain`, `W3C`, or `Raw` format.
    field_delimiter: ?[]const u8 = null,

    /// The unique ID that identifies this delivery in your account.
    id: ?[]const u8 = null,

    /// The record fields used in this delivery.
    record_fields: ?[]const []const u8 = null,

    /// This structure contains delivery configurations that apply only when the
    /// delivery
    /// destination resource is an S3 bucket.
    s_3_delivery_configuration: ?S3DeliveryConfiguration = null,

    /// The tags that have been assigned to this delivery.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .delivery_destination_arn = "deliveryDestinationArn",
        .delivery_destination_type = "deliveryDestinationType",
        .delivery_source_name = "deliverySourceName",
        .field_delimiter = "fieldDelimiter",
        .id = "id",
        .record_fields = "recordFields",
        .s_3_delivery_configuration = "s3DeliveryConfiguration",
        .tags = "tags",
    };
};
