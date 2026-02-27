const InspectorEvent = @import("inspector_event.zig").InspectorEvent;
const AssessmentRunNotificationSnsStatusCode = @import("assessment_run_notification_sns_status_code.zig").AssessmentRunNotificationSnsStatusCode;

/// Used as one of the elements of the AssessmentRun data
/// type.
pub const AssessmentRunNotification = struct {
    /// The date of the notification.
    date: i64,

    /// The Boolean value that specifies whether the notification represents an
    /// error.
    @"error": bool,

    /// The event for which a notification is sent.
    event: InspectorEvent,

    /// The message included in the notification.
    message: ?[]const u8,

    /// The status code of the SNS notification.
    sns_publish_status_code: ?AssessmentRunNotificationSnsStatusCode,

    /// The SNS topic to which the SNS notification is sent.
    sns_topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .date = "date",
        .@"error" = "error",
        .event = "event",
        .message = "message",
        .sns_publish_status_code = "snsPublishStatusCode",
        .sns_topic_arn = "snsTopicArn",
    };
};
