const NotificationSeverityLevel = @import("notification_severity_level.zig").NotificationSeverityLevel;

/// The configuration for a Slack channel that you added for your Amazon Web
/// Services account.
pub const SlackChannelConfiguration = struct {
    /// The channel ID in Slack. This ID identifies a channel within a Slack
    /// workspace.
    channel_id: []const u8,

    /// The name of the Slack channel that you configured with the Amazon Web
    /// Services Support App for your
    /// Amazon Web Services account.
    channel_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an IAM role that you want to
    /// use to perform operations on Amazon Web Services. For more information, see
    /// [Managing access to
    /// the Amazon Web Services Support
    /// App](https://docs.aws.amazon.com/awssupport/latest/user/support-app-permissions.html) in the *Amazon Web Services Support User Guide*.
    channel_role_arn: ?[]const u8,

    /// Whether you want to get notified when a support case has a new
    /// correspondence.
    notify_on_add_correspondence_to_case: ?bool,

    /// The case severity for a support case that you want to receive notifications.
    notify_on_case_severity: ?NotificationSeverityLevel,

    /// Whether you want to get notified when a support case is created or reopened.
    notify_on_create_or_reopen_case: ?bool,

    /// Whether you want to get notified when a support case is resolved.
    notify_on_resolve_case: ?bool,

    /// The team ID in Slack. This ID uniquely identifies a Slack workspace, such as
    /// `T012ABCDEFG`.
    team_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .channel_name = "channelName",
        .channel_role_arn = "channelRoleArn",
        .notify_on_add_correspondence_to_case = "notifyOnAddCorrespondenceToCase",
        .notify_on_case_severity = "notifyOnCaseSeverity",
        .notify_on_create_or_reopen_case = "notifyOnCreateOrReopenCase",
        .notify_on_resolve_case = "notifyOnResolveCase",
        .team_id = "teamId",
    };
};
