/// An Amazon SNS data source used for streaming labeling jobs.
pub const LabelingJobSnsDataSource = struct {
    /// The Amazon SNS input topic Amazon Resource Name (ARN). Specify the ARN of
    /// the input topic you will use to send new data objects to a streaming
    /// labeling job.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .sns_topic_arn = "SnsTopicArn",
    };
};
