const JobState = @import("job_state.zig").JobState;

/// The Amazon Simple Notification Service (Amazon SNS) notification settings
/// associated
/// with a specific job. The `Notification` object is returned as a part of the
/// response syntax of the `DescribeJob` action in the `JobMetadata` data
/// type.
///
/// When the notification settings are defined during job creation, you can
/// choose to
/// notify based on a specific set of job states using the `JobStatesToNotify`
/// array of
/// strings, or you can specify that you want to have Amazon SNS notifications
/// sent out for all
/// job states with `NotifyAll` set to true.
pub const Notification = struct {
    /// Used to send SNS notifications for the person picking up the device
    /// (identified during job creation).
    device_pickup_sns_topic_arn: ?[]const u8,

    /// The list of job states that will trigger a notification for this job.
    job_states_to_notify: ?[]const JobState,

    /// Any change in job state will trigger a notification for this job.
    notify_all: bool = false,

    /// The new SNS `TopicArn` that you want to associate with this job. You can
    /// create Amazon Resource Names (ARNs) for topics by using the
    /// [CreateTopic](https://docs.aws.amazon.com/sns/latest/api/API_CreateTopic.html) Amazon SNS API
    /// action.
    ///
    /// You can subscribe email addresses to an Amazon SNS topic through the Amazon
    /// Web Services Management Console, or by using the
    /// [Subscribe](https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html)
    /// Amazon Simple Notification
    /// Service (Amazon SNS) API action.
    sns_topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .device_pickup_sns_topic_arn = "DevicePickupSnsTopicARN",
        .job_states_to_notify = "JobStatesToNotify",
        .notify_all = "NotifyAll",
        .sns_topic_arn = "SnsTopicARN",
    };
};
