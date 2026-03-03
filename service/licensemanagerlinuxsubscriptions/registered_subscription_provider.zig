const SubscriptionProviderSource = @import("subscription_provider_source.zig").SubscriptionProviderSource;
const SubscriptionProviderStatus = @import("subscription_provider_status.zig").SubscriptionProviderStatus;

/// A third-party provider for operating system (OS) platform software and
/// license
/// subscriptions, such as Red Hat. When you register a third-party Linux
/// subscription
/// provider, License Manager can get subscription data from the registered
/// provider.
pub const RegisteredSubscriptionProvider = struct {
    /// The timestamp from the last time that License Manager accessed third-party
    /// subscription data
    /// for your account from your registered Linux subscription provider.
    last_successful_data_retrieval_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret that stores
    /// your registered Linux subscription provider
    /// access token. For RHEL account subscriptions, this is the offline token.
    secret_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Linux subscription provider resource
    /// that you registered.
    subscription_provider_arn: ?[]const u8 = null,

    /// A supported third-party Linux subscription provider. License Manager
    /// currently supports
    /// Red Hat subscriptions.
    subscription_provider_source: ?SubscriptionProviderSource = null,

    /// Indicates the status of your registered Linux subscription provider access
    /// token
    /// from the last time License Manager retrieved subscription data. For RHEL
    /// account subscriptions,
    /// this is the status of the offline token.
    subscription_provider_status: ?SubscriptionProviderStatus = null,

    /// A detailed message that's associated with your BYOL subscription
    /// provider token status.
    subscription_provider_status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_successful_data_retrieval_time = "LastSuccessfulDataRetrievalTime",
        .secret_arn = "SecretArn",
        .subscription_provider_arn = "SubscriptionProviderArn",
        .subscription_provider_source = "SubscriptionProviderSource",
        .subscription_provider_status = "SubscriptionProviderStatus",
        .subscription_provider_status_message = "SubscriptionProviderStatusMessage",
    };
};
