/// Configuration information of a Kinesis data stream.
pub const KinesisStreamConfig = struct {
    /// The Amazon Resource Name (ARN) of the data stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .stream_arn = "StreamArn",
    };
};
