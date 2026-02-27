/// The Amazon Data Firehose logging configuration settings for the pipe.
pub const FirehoseLogDestination = struct {
    /// The Amazon Resource Name (ARN) of the Firehose delivery stream to which
    /// EventBridge delivers the pipe log records.
    delivery_stream_arn: ?[]const u8,

    pub const json_field_names = .{
        .delivery_stream_arn = "DeliveryStreamArn",
    };
};
