/// A structure containing the alert target ARN and the role ARN.
pub const AlertTarget = struct {
    /// The Amazon Resource Name (ARN) of the notification target to which alerts
    /// are sent.
    alert_target_arn: []const u8,

    /// The ARN of the role that grants permission to send alerts to the
    /// notification target.
    role_arn: []const u8,

    pub const json_field_names = .{
        .alert_target_arn = "alertTargetArn",
        .role_arn = "roleArn",
    };
};
