pub const UpdateAccountSettingsRequest = struct {
    /// The ID for the Amazon Web Services account that contains the Quick Sight
    /// settings that you want to
    /// list.
    aws_account_id: []const u8,

    /// The default namespace for this Amazon Web Services account. Currently, the
    /// default is
    /// `default`. IAM users that
    /// register for the first time with Amazon Quick Sight provide an email address
    /// that becomes
    /// associated with the default namespace.
    default_namespace: []const u8,

    /// The email address that you want Quick Sight to send notifications to
    /// regarding your
    /// Amazon Web Services account or Quick Sight subscription.
    notification_email: ?[]const u8 = null,

    /// A boolean value that determines whether or not an Quick Sight account can be
    /// deleted. A `True` value doesn't allow the account to be deleted and results
    /// in an error message if a user tries to make a `DeleteAccountSubscription`
    /// request. A `False` value will allow the account to be deleted.
    termination_protection_enabled: ?bool = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .default_namespace = "DefaultNamespace",
        .notification_email = "NotificationEmail",
        .termination_protection_enabled = "TerminationProtectionEnabled",
    };
};
