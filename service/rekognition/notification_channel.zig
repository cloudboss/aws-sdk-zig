/// The Amazon Simple Notification Service topic to which Amazon Rekognition
/// publishes the completion status of a video analysis operation. For more
/// information, see
/// [Calling Amazon Rekognition Video
/// operations](https://docs.aws.amazon.com/rekognition/latest/dg/api-video.html). Note that the Amazon SNS topic must have a topic name that begins with *AmazonRekognition* if you are using the AmazonRekognitionServiceRole permissions policy to access the topic.
/// For more information, see [Giving access to multiple Amazon SNS
/// topics](https://docs.aws.amazon.com/rekognition/latest/dg/api-video-roles.html#api-video-roles-all-topics).
pub const NotificationChannel = struct {
    /// The ARN of an IAM role that gives Amazon Rekognition publishing permissions
    /// to the Amazon SNS topic.
    role_arn: []const u8,

    /// The Amazon SNS topic to which Amazon Rekognition posts the completion
    /// status.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .sns_topic_arn = "SNSTopicArn",
    };
};
