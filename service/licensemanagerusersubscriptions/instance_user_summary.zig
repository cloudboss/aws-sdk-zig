const IdentityProvider = @import("identity_provider.zig").IdentityProvider;

/// Describes users of an EC2 instance providing user-based subscriptions.
pub const InstanceUserSummary = struct {
    /// The date a user was associated with an EC2 instance.
    association_date: ?[]const u8 = null,

    /// The date a user was disassociated from an EC2 instance.
    disassociation_date: ?[]const u8 = null,

    /// The domain name of the Active Directory that contains the user information
    /// for the product subscription.
    domain: ?[]const u8 = null,

    /// The `IdentityProvider` resource specifies details about the identity
    /// provider.
    identity_provider: IdentityProvider,

    /// The ID of the EC2 instance that provides user-based subscriptions.
    instance_id: []const u8,

    /// The Amazon Resource Name (ARN) that identifies the instance user.
    instance_user_arn: ?[]const u8 = null,

    /// The status of a user associated with an EC2 instance.
    status: []const u8,

    /// The status message for users of an EC2 instance.
    status_message: ?[]const u8 = null,

    /// The user name from the identity provider for the user.
    username: []const u8,

    pub const json_field_names = .{
        .association_date = "AssociationDate",
        .disassociation_date = "DisassociationDate",
        .domain = "Domain",
        .identity_provider = "IdentityProvider",
        .instance_id = "InstanceId",
        .instance_user_arn = "InstanceUserArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .username = "Username",
    };
};
