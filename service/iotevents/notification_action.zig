const NotificationTargetActions = @import("notification_target_actions.zig").NotificationTargetActions;
const EmailConfiguration = @import("email_configuration.zig").EmailConfiguration;
const SMSConfiguration = @import("sms_configuration.zig").SMSConfiguration;

/// Contains the notification settings of an alarm model.
/// The settings apply to all alarms that were created based on this alarm
/// model.
pub const NotificationAction = struct {
    /// Specifies an AWS Lambda function to manage alarm notifications.
    /// You can create one or use the [AWS Lambda function provided by AWS IoT
    /// Events](https://docs.aws.amazon.com/iotevents/latest/developerguide/lambda-support.html).
    action: NotificationTargetActions,

    /// Contains the configuration information of email notifications.
    email_configurations: ?[]const EmailConfiguration,

    /// Contains the configuration information of SMS notifications.
    sms_configurations: ?[]const SMSConfiguration,

    pub const json_field_names = .{
        .action = "action",
        .email_configurations = "emailConfigurations",
        .sms_configurations = "smsConfigurations",
    };
};
