/// Specifies the Amazon Resource Name (ARN) of an event stream to publish
/// events to and the AWS Identity and Access Management (IAM) role to use when
/// publishing those events.
pub const WriteEventStream = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Kinesis data stream or Amazon
    /// Kinesis Data Firehose delivery stream that you want to publish event data
    /// to.
    ///
    /// For a Kinesis data stream, the ARN format is:
    /// arn:aws:kinesis:region:account-id:stream/stream_name
    ///
    /// For a Kinesis Data Firehose delivery stream, the ARN format is:
    /// arn:aws:firehose:region:account-id:deliverystream/stream_name
    destination_stream_arn: []const u8,

    /// The AWS Identity and Access Management (IAM) role that authorizes Amazon
    /// Pinpoint to publish event data to the stream in your AWS account.
    role_arn: []const u8,

    pub const json_field_names = .{
        .destination_stream_arn = "DestinationStreamArn",
        .role_arn = "RoleArn",
    };
};
