const S3DeliveryConfiguration = @import("s3_delivery_configuration.zig").S3DeliveryConfiguration;

/// This structure contains the default values that are used for each
/// configuration parameter
/// when you use
/// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) to create a deliver under the current service type, resource type,
/// and log type.
pub const ConfigurationTemplateDeliveryConfigValues = struct {
    /// The default field delimiter that is used in a
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) operation when the field delimiter is not specified in that
    /// operation. The field delimiter is used only when the final output delivery
    /// is in
    /// `Plain`, `W3C`, or `Raw` format.
    field_delimiter: ?[]const u8 = null,

    /// The default record fields that will be delivered when a list of record
    /// fields is not
    /// provided in a
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) operation.
    record_fields: ?[]const []const u8 = null,

    /// The delivery parameters that are used when you create a delivery to a
    /// delivery destination
    /// that is an S3 Bucket.
    s_3_delivery_configuration: ?S3DeliveryConfiguration = null,

    pub const json_field_names = .{
        .field_delimiter = "fieldDelimiter",
        .record_fields = "recordFields",
        .s_3_delivery_configuration = "s3DeliveryConfiguration",
    };
};
