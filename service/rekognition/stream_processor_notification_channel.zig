/// The Amazon Simple Notification Service topic to which Amazon Rekognition
/// publishes the object detection results and completion status of a video
/// analysis operation.
///
/// Amazon Rekognition publishes a notification the first time an object of
/// interest or a person is detected in the video stream. For example, if Amazon
/// Rekognition
/// detects a person at second 2, a pet at second 4, and a person again at
/// second 5, Amazon Rekognition sends 2 object class detected notifications,
/// one for a person at second 2 and one for a pet at second 4.
///
/// Amazon Rekognition also publishes an an end-of-session notification with a
/// summary when the stream processing session is complete.
pub const StreamProcessorNotificationChannel = struct {
    /// The Amazon Resource Number (ARN) of the Amazon Amazon Simple Notification
    /// Service topic to which Amazon Rekognition posts the completion status.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .sns_topic_arn = "SNSTopicArn",
    };
};
