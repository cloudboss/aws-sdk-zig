const HttpsNotificationConfiguration = @import("https_notification_configuration.zig").HttpsNotificationConfiguration;
const SqsNotificationConfiguration = @import("sqs_notification_configuration.zig").SqsNotificationConfiguration;

/// Specify the configurations you want to use for subscriber notification to
/// notify the
/// subscriber when new data is written to the data lake for sources that the
/// subscriber
/// consumes in Security Lake.
pub const NotificationConfiguration = union(enum) {
    /// The configurations used for HTTPS subscriber notification.
    https_notification_configuration: ?HttpsNotificationConfiguration,
    /// The configurations for SQS subscriber notification.
    sqs_notification_configuration: ?SqsNotificationConfiguration,

    pub const json_field_names = .{
        .https_notification_configuration = "httpsNotificationConfiguration",
        .sqs_notification_configuration = "sqsNotificationConfiguration",
    };
};
