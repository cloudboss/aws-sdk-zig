/// For a SQL-based Kinesis Data Analytics application, when configuring
/// application
/// output, identifies a Kinesis Data Firehose delivery stream as the
/// destination. You provide the
/// stream Amazon Resource Name (ARN) of the delivery stream.
pub const KinesisFirehoseOutput = struct {
    /// The ARN of the destination delivery stream to write to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
