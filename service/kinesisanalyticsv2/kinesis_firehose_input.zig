/// For a SQL-based Kinesis Data Analytics application, identifies a Kinesis
/// Data
/// Firehose delivery stream as the streaming source. You provide the delivery
/// stream's Amazon
/// Resource Name (ARN).
pub const KinesisFirehoseInput = struct {
    /// The Amazon Resource Name (ARN) of the delivery stream.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
    };
};
