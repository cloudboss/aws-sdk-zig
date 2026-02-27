const AuthMaterial = @import("auth_material.zig").AuthMaterial;
const OAuthConfig = @import("o_auth_config.zig").OAuthConfig;

/// The authentication configuration details for a connector destination,
/// including OAuth settings and other authentication parameters.
pub const AuthConfig = struct {
    /// The authorization materials for General Authorization.
    general_authorization: ?[]const AuthMaterial,

    /// The OAuth configuration settings used for authentication with the
    /// third-party service.
    o_auth: ?OAuthConfig,

    pub const json_field_names = .{
        .general_authorization = "GeneralAuthorization",
        .o_auth = "oAuth",
    };
};
