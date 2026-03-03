/// The settings for delivering logs to Amazon Kinesis Data Firehose.
pub const FirehoseLogDelivery = struct {
    /// The name of the Kinesis Data Firehose delivery stream that is the
    /// destination for log delivery.
    delivery_stream: ?[]const u8 = null,

    /// Specifies whether connector logs get delivered to Amazon Kinesis Data
    /// Firehose.
    enabled: bool = false,

    pub const json_field_names = .{
        .delivery_stream = "deliveryStream",
        .enabled = "enabled",
    };
};
