const Oauth2AuthorizationServerMetadata = @import("oauth_2_authorization_server_metadata.zig").Oauth2AuthorizationServerMetadata;

/// Contains the discovery information for an OAuth2 provider.
pub const Oauth2Discovery = union(enum) {
    /// The authorization server metadata for the OAuth2 provider.
    authorization_server_metadata: ?Oauth2AuthorizationServerMetadata,
    /// The discovery URL for the OAuth2 provider.
    discovery_url: ?[]const u8,

    pub const json_field_names = .{
        .authorization_server_metadata = "authorizationServerMetadata",
        .discovery_url = "discoveryUrl",
    };
};
