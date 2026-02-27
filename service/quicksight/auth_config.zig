const AuthenticationMetadata = @import("authentication_metadata.zig").AuthenticationMetadata;
const ConnectionAuthType = @import("connection_auth_type.zig").ConnectionAuthType;

/// Authentication configuration for connecting to external services.
pub const AuthConfig = struct {
    /// The authentication metadata containing the specific configuration for the
    /// chosen authentication type.
    authentication_metadata: AuthenticationMetadata,

    /// The type of authentication method.
    authentication_type: ConnectionAuthType,

    pub const json_field_names = .{
        .authentication_metadata = "AuthenticationMetadata",
        .authentication_type = "AuthenticationType",
    };
};
