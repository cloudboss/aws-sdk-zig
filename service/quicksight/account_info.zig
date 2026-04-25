const Edition = @import("edition.zig").Edition;

/// A structure that contains the following account information elements:
///
/// * Your Quick Sight account name.
///
/// * The edition of Quick Sight that your account is using.
///
/// * The notification email address that is associated with the Quick Sight
///   account.
///
/// * The authentication type of the Quick Sight account.
///
/// * The status of the Quick Sight account's subscription.
pub const AccountInfo = struct {
    /// The account name that you provided for the Amazon Quick Sight subscription
    /// in your
    /// Amazon Web Services account. You create this name when you sign up for
    /// Quick. It's unique over all of Amazon Web Services, and it appears only when
    /// users sign in.
    account_name: ?[]const u8 = null,

    /// The status of your account subscription.
    account_subscription_status: ?[]const u8 = null,

    /// The way that your Amazon Quick Sight account is authenticated.
    authentication_type: ?[]const u8 = null,

    /// The edition of your Quick Sight account.
    edition: ?Edition = null,

    /// The Amazon Resource Name (ARN) for the IAM Identity Center instance.
    iam_identity_center_instance_arn: ?[]const u8 = null,

    /// The email address that will be used for Quick Sight to send notifications
    /// regarding your Amazon Web Services account or Quick Sight subscription.
    notification_email: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .account_subscription_status = "AccountSubscriptionStatus",
        .authentication_type = "AuthenticationType",
        .edition = "Edition",
        .iam_identity_center_instance_arn = "IAMIdentityCenterInstanceArn",
        .notification_email = "NotificationEmail",
    };
};
