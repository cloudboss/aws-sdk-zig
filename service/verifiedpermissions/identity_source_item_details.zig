const OpenIdIssuer = @import("open_id_issuer.zig").OpenIdIssuer;

/// A structure that contains configuration of the identity source.
///
/// This data type was a response parameter for the
/// [ListIdentitySources](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListIdentitySources.html) operation. Replaced by [ConfigurationItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ConfigurationItem.html).
pub const IdentitySourceItemDetails = struct {
    /// The application client IDs associated with the specified Amazon Cognito user
    /// pool that are enabled for this identity source.
    client_ids: ?[]const []const u8 = null,

    /// The well-known URL that points to this user pool's OIDC discovery endpoint.
    /// This is a URL string in the following format. This URL replaces the
    /// placeholders for both the Amazon Web Services Region and the user pool
    /// identifier with those appropriate for this user pool.
    ///
    /// `https://cognito-idp.*<region>*.amazonaws.com/*<user-pool-id>*/.well-known/openid-configuration`
    discovery_url: ?[]const u8 = null,

    /// A string that identifies the type of OIDC service represented by this
    /// identity source.
    ///
    /// At this time, the only valid value is `cognito`.
    open_id_issuer: ?OpenIdIssuer = null,

    /// The Amazon Cognito user pool whose identities are accessible to this
    /// Verified Permissions policy store.
    user_pool_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_ids = "clientIds",
        .discovery_url = "discoveryUrl",
        .open_id_issuer = "openIdIssuer",
        .user_pool_arn = "userPoolArn",
    };
};
