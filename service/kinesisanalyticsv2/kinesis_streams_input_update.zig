/// When you update the input configuration for a SQL-based Kinesis Data
/// Analytics application, provides information about a
/// Kinesis stream as the streaming
/// source.
pub const KinesisStreamsInputUpdate = struct {
    /// The Amazon Resource Name (ARN) of the input Kinesis data stream to read.
    resource_arn_update: []const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
    };
};
