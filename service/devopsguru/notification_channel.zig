const NotificationChannelConfig = @import("notification_channel_config.zig").NotificationChannelConfig;

/// Information about a notification channel. A notification channel is used to
/// notify
/// you when DevOps Guru creates an insight. The one
/// supported notification channel is Amazon Simple Notification Service (Amazon
/// SNS).
///
/// If you use an Amazon SNS topic in another account, you must attach a policy
/// to it that grants DevOps Guru permission
/// to send it notifications. DevOps Guru adds the required policy on your
/// behalf to send notifications using Amazon SNS in your account. DevOps Guru
/// only supports standard SNS topics.
/// For more information, see [Permissions
/// for Amazon SNS
/// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-required-permissions.html).
///
/// If you use an Amazon SNS topic that is encrypted by an Amazon Web Services
/// Key Management Service customer-managed key (CMK), then you must add
/// permissions
/// to the CMK. For more information, see [Permissions for
/// Amazon Web Services KMS–encrypted Amazon SNS
/// topics](https://docs.aws.amazon.com/devops-guru/latest/userguide/sns-kms-permissions.html).
pub const NotificationChannel = struct {
    /// A `NotificationChannelConfig` object that contains information about
    /// configured notification channels.
    config: ?NotificationChannelConfig,

    /// The ID of a notification channel.
    id: ?[]const u8,

    pub const json_field_names = .{
        .config = "Config",
        .id = "Id",
    };
};
