/// For a SQL-based Kinesis Data Analytics application, when updating
/// application
/// input configuration, provides information about a Kinesis Data Firehose
/// delivery stream as the
/// streaming source.
pub const KinesisFirehoseInputUpdate = struct {
    /// The Amazon Resource Name (ARN) of the input delivery stream to read.
    resource_arn_update: []const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
    };
};
