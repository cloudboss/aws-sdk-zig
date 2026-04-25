const GeneralAuthorizationUpdate = @import("general_authorization_update.zig").GeneralAuthorizationUpdate;
const OAuthUpdate = @import("o_auth_update.zig").OAuthUpdate;

/// The updated authentication configuration details for a connector
/// destination.
pub const AuthConfigUpdate = struct {
    /// The General Authorization update information containing authorization
    /// materials to add or update.
    general_authorization_update: ?GeneralAuthorizationUpdate = null,

    /// The updated OAuth configuration settings for the authentication
    /// configuration.
    o_auth_update: ?OAuthUpdate = null,

    pub const json_field_names = .{
        .general_authorization_update = "GeneralAuthorizationUpdate",
        .o_auth_update = "oAuthUpdate",
    };
};
