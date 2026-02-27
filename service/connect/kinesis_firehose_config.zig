/// Configuration information of a Kinesis Data Firehose delivery stream.
pub const KinesisFirehoseConfig = struct {
    /// The Amazon Resource Name (ARN) of the delivery stream.
    firehose_arn: []const u8,

    pub const json_field_names = .{
        .firehose_arn = "FirehoseArn",
    };
};
