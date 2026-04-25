const OAuth2AuthorizationData = @import("o_auth_2_authorization_data.zig").OAuth2AuthorizationData;

/// Contains the authorization data that is returned when a gateway target is
/// configured with a credential provider with authorization code grant type and
/// requires user federation.
pub const AuthorizationData = union(enum) {
    /// OAuth2 authorization data for the gateway target.
    oauth_2: ?OAuth2AuthorizationData,

    pub const json_field_names = .{
        .oauth_2 = "oauth2",
    };
};
