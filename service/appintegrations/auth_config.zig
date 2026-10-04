const AuthType = @import("auth_type.zig").AuthType;

/// Contains the authentication settings that Connect Customer uses to call an
/// external application endpoint. The configuration includes the authentication
/// type and credential location.
pub const AuthConfig = struct {
    /// The type of authentication used when calling the external application.
    auth_type: ?AuthType = null,

    /// The ARN of the Secrets Manager secret that stores the credentials. The
    /// secret must be accessible to Connect Customer.
    credential_provider_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "AuthType",
        .credential_provider_identifier = "CredentialProviderIdentifier",
    };
};
