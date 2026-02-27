const IdentityProvider = @import("identity_provider.zig").IdentityProvider;

/// Describes an EC2 instance providing user-based subscriptions.
pub const InstanceSummary = struct {
    /// The `IdentityProvider` resource specifies details about the identity
    /// provider.
    identity_provider: ?IdentityProvider,

    /// The ID of the EC2 instance, which provides user-based subscriptions.
    instance_id: []const u8,

    /// The date of the last status check.
    last_status_check_date: ?[]const u8,

    /// The AWS Account ID of the owner of this resource.
    owner_account_id: ?[]const u8,

    /// A list of provided user-based subscription products.
    products: []const []const u8,

    /// The status of an EC2 instance resource.
    status: []const u8,

    /// The status message for an EC2 instance.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
        .instance_id = "InstanceId",
        .last_status_check_date = "LastStatusCheckDate",
        .owner_account_id = "OwnerAccountId",
        .products = "Products",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
