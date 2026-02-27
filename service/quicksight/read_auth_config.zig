const ReadAuthenticationMetadata = @import("read_authentication_metadata.zig").ReadAuthenticationMetadata;
const ConnectionAuthType = @import("connection_auth_type.zig").ConnectionAuthType;

/// Read-only authentication configuration containing non-sensitive
/// authentication details for action connectors.
pub const ReadAuthConfig = struct {
    /// The authentication metadata containing configuration details specific to the
    /// authentication type.
    authentication_metadata: ReadAuthenticationMetadata,

    /// The type of authentication being used (BASIC, API_KEY,
    /// OAUTH2_CLIENT_CREDENTIALS, or OAUTH2_AUTHORIZATION_CODE).
    authentication_type: ConnectionAuthType,

    pub const json_field_names = .{
        .authentication_metadata = "AuthenticationMetadata",
        .authentication_type = "AuthenticationType",
    };
};
