/// Contains information about the Amazon Kinesis data stream where you are
/// sending real-time log data.
pub const KinesisStreamConfig = struct {
    /// The Amazon Resource Name (ARN) of an Identity and Access Management (IAM)
    /// role that CloudFront can use to send real-time log data to your Kinesis data
    /// stream.
    ///
    /// For more information the IAM role, see [Real-time log configuration IAM
    /// role](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html#understand-real-time-log-config-iam-role) in the *Amazon CloudFront Developer Guide*.
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Kinesis data stream where you are
    /// sending real-time log data.
    stream_arn: []const u8,
};
