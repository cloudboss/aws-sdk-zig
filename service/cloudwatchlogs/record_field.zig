/// A structure that represents a valid record field header and whether it is
/// mandatory.
pub const RecordField = struct {
    /// If this is `true`, the record field must be present in the
    /// `recordFields` parameter provided to a
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) or [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html) operation.
    mandatory: ?bool = null,

    /// The name to use when specifying this record field in a
    /// [CreateDelivery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_CreateDelivery.html) or [UpdateDeliveryConfiguration](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateDeliveryConfiguration.html) operation.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .mandatory = "mandatory",
        .name = "name",
    };
};
