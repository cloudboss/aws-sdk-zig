const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const Settings = @import("settings.zig").Settings;

/// Describes an identity provider.
pub const IdentityProviderSummary = struct {
    /// The failure message associated with an identity provider.
    failure_message: ?[]const u8,

    /// The `IdentityProvider` resource contains information about an identity
    /// provider.
    identity_provider: IdentityProvider,

    /// The Amazon Resource Name (ARN) of the identity provider.
    identity_provider_arn: ?[]const u8,

    /// The AWS Account ID of the owner of this resource.
    owner_account_id: ?[]const u8,

    /// The name of the user-based subscription product.
    product: []const u8,

    /// The `Settings` resource contains details about the registered identity
    /// provider’s product related configuration settings, such as the subnets to
    /// provision VPC endpoints.
    settings: Settings,

    /// The status of the identity provider.
    status: []const u8,

    pub const json_field_names = .{
        .failure_message = "FailureMessage",
        .identity_provider = "IdentityProvider",
        .identity_provider_arn = "IdentityProviderArn",
        .owner_account_id = "OwnerAccountId",
        .product = "Product",
        .settings = "Settings",
        .status = "Status",
    };
};
