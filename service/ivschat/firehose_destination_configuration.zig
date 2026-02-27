/// Specifies a Kinesis Firehose location where chat logs will be stored.
pub const FirehoseDestinationConfiguration = struct {
    /// Name of the Amazon Kinesis Firehose delivery stream where chat activity will
    /// be
    /// logged.
    delivery_stream_name: []const u8,

    pub const json_field_names = .{
        .delivery_stream_name = "deliveryStreamName",
    };
};
