/// Identifies a Kinesis data stream as the streaming source. You provide the
/// stream's Amazon Resource Name (ARN).
pub const KinesisStreamsInput = struct {
    /// The ARN of the input Kinesis data stream to read.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
