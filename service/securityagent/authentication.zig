const AuthenticationProviderType = @import("authentication_provider_type.zig").AuthenticationProviderType;

/// The authentication configuration for an actor, specifying the provider type
/// and credentials.
pub const Authentication = struct {
    /// The type of authentication provider. Valid values include SECRETS_MANAGER,
    /// AWS_LAMBDA, AWS_IAM_ROLE, and AWS_INTERNAL.
    provider_type: ?AuthenticationProviderType = null,

    /// The authentication value, such as a secret ARN, Lambda function ARN, or IAM
    /// role ARN, depending on the provider type.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .provider_type = "providerType",
        .value = "value",
    };
};
