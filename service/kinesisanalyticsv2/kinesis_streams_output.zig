/// When you configure a SQL-based Kinesis Data Analytics application's output,
/// identifies a Kinesis data stream as the destination. You provide the stream
/// Amazon Resource
/// Name (ARN).
pub const KinesisStreamsOutput = struct {
    /// The ARN of the destination Kinesis data stream to write to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
