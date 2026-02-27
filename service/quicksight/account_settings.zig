const Edition = @import("edition.zig").Edition;

/// The Quick Sight settings associated with your Amazon Web Services account.
pub const AccountSettings = struct {
    /// The "account name" you provided for the Quick Sight subscription in your
    /// Amazon Web Services account.
    /// You create this name when you sign up for Quick Sight. It is unique in all
    /// of Amazon Web Services and
    /// it appears only when users sign in.
    account_name: ?[]const u8,

    /// The default Quick Sight namespace for your Amazon Web Services account.
    default_namespace: ?[]const u8,

    /// The edition of Quick Sight that you're currently subscribed to:
    /// Enterprise edition or Standard edition.
    edition: ?Edition,

    /// The main notification email for your Quick Sight subscription.
    notification_email: ?[]const u8,

    /// A Boolean value that indicates whether public sharing is turned on for an
    /// Quick Suite account. For more information about turning on public sharing,
    /// see
    /// [UpdatePublicSharingSettings](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdatePublicSharingSettings.html).
    public_sharing_enabled: bool = false,

    /// A boolean value that determines whether or not an Quick Sight account can be
    /// deleted. A `True` value doesn't allow the account to be deleted and results
    /// in an error message if a user tries to make a `DeleteAccountSubsctiption`
    /// request. A `False` value will allow the ccount to be deleted.
    termination_protection_enabled: bool = false,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .default_namespace = "DefaultNamespace",
        .edition = "Edition",
        .notification_email = "NotificationEmail",
        .public_sharing_enabled = "PublicSharingEnabled",
        .termination_protection_enabled = "TerminationProtectionEnabled",
    };
};
