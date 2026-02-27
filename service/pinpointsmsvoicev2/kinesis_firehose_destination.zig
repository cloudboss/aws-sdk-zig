/// Contains the delivery stream Amazon Resource Name (ARN), and the ARN of the
/// Identity and Access Management (IAM) role associated with a Firehose event
/// destination.
///
/// Event destinations, such as Firehose, are associated with configuration
/// sets, which enable you to publish message sending events.
pub const KinesisFirehoseDestination = struct {
    /// The Amazon Resource Name (ARN) of the delivery stream.
    delivery_stream_arn: []const u8,

    /// The ARN of an Identity and Access Management role that is able to write
    /// event data to an Amazon Data Firehose destination.
    iam_role_arn: []const u8,

    pub const json_field_names = .{
        .delivery_stream_arn = "DeliveryStreamArn",
        .iam_role_arn = "IamRoleArn",
    };
};
