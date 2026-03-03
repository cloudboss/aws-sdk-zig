const MemberAccountNotificationConfigurationStatus = @import("member_account_notification_configuration_status.zig").MemberAccountNotificationConfigurationStatus;

/// Contains information about a member account.
pub const MemberAccount = struct {
    /// The AWS account ID of the member account.
    account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the notification configuration associated
    /// with the member account.
    notification_configuration_arn: ?[]const u8 = null,

    /// The unique identifier of the organizational unit containing the member
    /// account.
    organizational_unit_id: []const u8,

    /// The current status of the member account.
    status: MemberAccountNotificationConfigurationStatus,

    /// The reason for the current status of the member account.
    status_reason: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .notification_configuration_arn = "notificationConfigurationArn",
        .organizational_unit_id = "organizationalUnitId",
        .status = "status",
        .status_reason = "statusReason",
    };
};
