/// Details about a Kinesis data stream used as the source for a Firehose
/// stream.
pub const KinesisStreamSourceDescription = struct {
    /// Firehose starts retrieving records from the Kinesis data stream starting
    /// with this timestamp.
    delivery_start_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the source Kinesis data stream. For more
    /// information, see [Amazon
    /// Kinesis Data Streams ARN
    /// Format](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams).
    kinesis_stream_arn: ?[]const u8 = null,

    /// The ARN of the role used by the source Kinesis data stream. For more
    /// information, see
    /// [Amazon Web Services
    /// Identity and Access Management (IAM) ARN
    /// Format](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_start_timestamp = "DeliveryStartTimestamp",
        .kinesis_stream_arn = "KinesisStreamARN",
        .role_arn = "RoleARN",
    };
};
