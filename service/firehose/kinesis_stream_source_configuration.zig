/// The stream and role Amazon Resource Names (ARNs) for a Kinesis data stream
/// used as
/// the source for a Firehose stream.
pub const KinesisStreamSourceConfiguration = struct {
    /// The ARN of the source Kinesis data stream. For more information, see [Amazon
    /// Kinesis Data Streams ARN
    /// Format](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kinesis-streams).
    kinesis_stream_arn: []const u8,

    /// The ARN of the role that provides access to the source Kinesis data stream.
    /// For more
    /// information, see [Amazon Web Services
    /// Identity and Access Management (IAM) ARN
    /// Format](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam).
    role_arn: []const u8,

    pub const json_field_names = .{
        .kinesis_stream_arn = "KinesisStreamARN",
        .role_arn = "RoleARN",
    };
};
