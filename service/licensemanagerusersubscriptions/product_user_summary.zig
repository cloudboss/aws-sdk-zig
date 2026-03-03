const IdentityProvider = @import("identity_provider.zig").IdentityProvider;

/// A summary of the user-based subscription products for a specific user.
pub const ProductUserSummary = struct {
    /// The domain name of the Active Directory that contains the user information
    /// for the product subscription.
    domain: ?[]const u8 = null,

    /// An object that specifies details for the identity provider.
    identity_provider: IdentityProvider,

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
        .product = "Product",
        .product_user_arn = "ProductUserArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .subscription_end_date = "SubscriptionEndDate",
        .subscription_start_date = "SubscriptionStartDate",
        .username = "Username",
    };
};
