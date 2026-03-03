/// Information about the targets to which audit notifications are sent.
pub const AuditNotificationTarget = struct {
    /// True if notifications to the target are enabled.
    enabled: bool = false,

    /// The ARN of the role that grants permission to send notifications to the
    /// target.
    role_arn: ?[]const u8 = null,

    /// The ARN of the target (SNS topic) to which audit notifications are sent.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .role_arn = "roleArn",
        .target_arn = "targetArn",
    };
};
