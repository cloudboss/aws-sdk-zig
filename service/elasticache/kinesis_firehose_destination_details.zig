/// The configuration details of the Kinesis Data Firehose destination.
pub const KinesisFirehoseDestinationDetails = struct {
    /// The name of the Kinesis Data Firehose delivery stream.
    delivery_stream: ?[]const u8 = null,
};
