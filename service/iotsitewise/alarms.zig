/// Contains the configuration information of an alarm created in an IoT
/// SiteWise Monitor portal.
/// You can use the alarm to monitor an asset property and get notified when the
/// asset property value is outside a specified range.
/// For more information, see [Monitoring with
/// alarms](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/monitor-alarms.html) in the *IoT SiteWise Application Guide*.
pub const Alarms = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IAM role that allows the alarm to perform actions and access Amazon Web Services
    /// resources and services, such as IoT Events.
    alarm_role_arn: []const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Lambda function that manages alarm notifications. For more
    /// information, see [Managing alarm
    /// notifications](https://docs.aws.amazon.com/iotevents/latest/developerguide/lambda-support.html) in the *IoT Events Developer Guide*.
    notification_lambda_arn: ?[]const u8,

    pub const json_field_names = .{
        .alarm_role_arn = "alarmRoleArn",
        .notification_lambda_arn = "notificationLambdaArn",
    };
};
