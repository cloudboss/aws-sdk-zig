const AuthorizationCodeGrantDetails = @import("authorization_code_grant_details.zig").AuthorizationCodeGrantDetails;

/// Details for OAuth 2.0 authorization code grant credentials.
pub const AuthorizationCodeGrantCredentialsDetails = union(enum) {
    /// The authorization code grant configuration details.
    authorization_code_grant_details: ?AuthorizationCodeGrantDetails,

    pub const json_field_names = .{
        .authorization_code_grant_details = "AuthorizationCodeGrantDetails",
    };
};
