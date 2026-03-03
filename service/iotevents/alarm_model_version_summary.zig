const AlarmModelVersionStatus = @import("alarm_model_version_status.zig").AlarmModelVersionStatus;

/// Contains a summary of an alarm model version.
pub const AlarmModelVersionSummary = struct {
    /// The ARN of the alarm model. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    alarm_model_arn: ?[]const u8 = null,

    /// The name of the alarm model.
    alarm_model_name: ?[]const u8 = null,

    /// The version of the alarm model.
    alarm_model_version: ?[]const u8 = null,

    /// The time the alarm model was created, in the Unix epoch format.
    creation_time: ?i64 = null,

    /// The time the alarm model was last updated, in the Unix epoch format.
    last_update_time: ?i64 = null,

    /// The ARN of the IAM role that allows the alarm to perform actions and access
    /// AWS resources. For more information, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    role_arn: ?[]const u8 = null,

    /// The status of the alarm model. The status can be one of the following
    /// values:
    ///
    /// * `ACTIVE` - The alarm model is active and it's ready to evaluate data.
    ///
    /// * `ACTIVATING` - AWS IoT Events is activating your alarm model.
    /// Activating an alarm model can take up to a few minutes.
    ///
    /// * `INACTIVE` - The alarm model is inactive, so it isn't ready to evaluate
    ///   data.
    /// Check your alarm model information and update the alarm model.
    ///
    /// * `FAILED` - You couldn't create or update the alarm model. Check your alarm
    ///   model information
    /// and try again.
    status: ?AlarmModelVersionStatus = null,

    /// Contains information about the status of the alarm model version.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarm_model_arn = "alarmModelArn",
        .alarm_model_name = "alarmModelName",
        .alarm_model_version = "alarmModelVersion",
        .creation_time = "creationTime",
        .last_update_time = "lastUpdateTime",
        .role_arn = "roleArn",
        .status = "status",
        .status_message = "statusMessage",
    };
};
