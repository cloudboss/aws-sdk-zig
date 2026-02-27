const ReadAuthorizationCodeGrantDetails = @import("read_authorization_code_grant_details.zig").ReadAuthorizationCodeGrantDetails;

/// Read-only credentials details for OAuth2 authorization code grant flow,
/// containing non-sensitive configuration information.
pub const ReadAuthorizationCodeGrantCredentialsDetails = union(enum) {
    /// The read-only authorization code grant configuration details.
    read_authorization_code_grant_details: ?ReadAuthorizationCodeGrantDetails,

    pub const json_field_names = .{
        .read_authorization_code_grant_details = "ReadAuthorizationCodeGrantDetails",
    };
};
