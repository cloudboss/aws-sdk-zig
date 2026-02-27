/// An object that defines an Amazon Kinesis Data Firehose destination for email
/// events. You can use Amazon Kinesis Data Firehose to
/// stream data to other services, such as Amazon S3 and Amazon Redshift.
pub const KinesisFirehoseDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Kinesis Data Firehose stream
    /// that the Amazon SES API v2 sends email
    /// events to.
    delivery_stream_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the Amazon SES API v2
    /// uses to send email
    /// events to the Amazon Kinesis Data Firehose stream.
    iam_role_arn: []const u8,

    pub const json_field_names = .{
        .delivery_stream_arn = "DeliveryStreamArn",
        .iam_role_arn = "IamRoleArn",
    };
};
