const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;

/// An object that contains information needed to create a data source
/// connection that uses OAuth client credentials. This option is available for
/// data source connections that are made with Snowflake and Starburst.
pub const OAuthParameters = struct {
    /// The resource uri of the identity provider.
    identity_provider_resource_uri: ?[]const u8 = null,

    identity_provider_vpc_connection_properties: ?VpcConnectionProperties = null,

    /// The OAuth scope.
    o_auth_scope: ?[]const u8 = null,

    /// The token endpoint URL of the identity provider.
    token_provider_url: []const u8,

    pub const json_field_names = .{
        .identity_provider_resource_uri = "IdentityProviderResourceUri",
        .identity_provider_vpc_connection_properties = "IdentityProviderVpcConnectionProperties",
        .o_auth_scope = "OAuthScope",
        .token_provider_url = "TokenProviderUrl",
    };
};
