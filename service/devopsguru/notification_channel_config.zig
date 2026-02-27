const NotificationFilterConfig = @import("notification_filter_config.zig").NotificationFilterConfig;
const SnsChannelConfig = @import("sns_channel_config.zig").SnsChannelConfig;

/// Information about notification channels you have configured with DevOps
/// Guru.
/// The one
/// supported notification channel is Amazon Simple Notification Service (Amazon
/// SNS).
pub const NotificationChannelConfig = struct {
    /// The filter configurations for the Amazon SNS notification topic you use with
    /// DevOps Guru.
    /// If you do not provide filter configurations, the default configurations are
    /// to receive notifications for all message types of `High` or `Medium`
    /// severity.
    filters: ?NotificationFilterConfig,

    /// Information about a notification channel configured in DevOps Guru to send
    /// notifications
    /// when insights are created.
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
    sns: SnsChannelConfig,

    pub const json_field_names = .{
        .filters = "Filters",
        .sns = "Sns",
    };
};
