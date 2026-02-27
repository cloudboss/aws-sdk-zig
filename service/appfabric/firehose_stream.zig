/// Contains information about an Amazon Kinesis Data Firehose delivery stream.
pub const FirehoseStream = struct {
    /// The name of the Amazon Kinesis Data Firehose delivery stream.
    stream_name: []const u8,

    pub const json_field_names = .{
        .stream_name = "streamName",
    };
};
