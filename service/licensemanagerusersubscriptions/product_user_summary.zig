const IdentityProvider = @import("identity_provider.zig").IdentityProvider;

/// A summary of the user-based subscription products for a specific user.
pub const ProductUserSummary = struct {
    /// The domain name of the Active Directory that contains the user information
    /// for the product subscription.
    domain: ?[]const u8 = null,

    /// An object that specifies details for the identity provider.
    identity_provider: IdentityProvider,

    /// The expiration date of the license associated with this subscription, in ISO
    /// 8601 UTC format (for example, `2025-03-15T00:00:00Z`).
    ///
    /// This field applies only to subscriptions that use license server endpoints,
    /// such as Remote Desktop Services (RDS) Subscriber Access License (SAL). It
    /// returns `null` for products that don't use license-based subscriptions.
    license_expiration_date: ?[]const u8 = null,

    /// The name of the user-based subscription product.
    product: []const u8,

    /// The Amazon Resource Name (ARN) for this product user.
    product_user_arn: ?[]const u8 = null,

    /// The status of a product for this user.
    status: []const u8,

    /// The status message for a product for this user.
    status_message: ?[]const u8 = null,

    /// The end date of a subscription.
    subscription_end_date: ?[]const u8 = null,

    /// The start date of a subscription.
    subscription_start_date: ?[]const u8 = null,

    /// The user name from the identity provider for this product user.
    username: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
        .identity_provider = "IdentityProvider",
        .license_expiration_date = "LicenseExpirationDate",
        .product = "Product",
        .product_user_arn = "ProductUserArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .subscription_end_date = "SubscriptionEndDate",
        .subscription_start_date = "SubscriptionStartDate",
        .username = "Username",
    };
};
