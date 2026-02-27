/// An object that contains information about an event destination that sends
/// data to Amazon Kinesis Data Firehose.
pub const KinesisFirehoseDestination = struct {
    /// The Amazon Resource Name (ARN) of an IAM role that can write data to an
    /// Amazon Kinesis Data Firehose stream.
    delivery_stream_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Kinesis Data Firehose
    /// destination that you want to use in the event destination.
    iam_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .delivery_stream_arn = "DeliveryStreamArn",
        .iam_role_arn = "IamRoleArn",
    };
};
