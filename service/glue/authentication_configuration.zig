const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const OAuth2Properties = @import("o_auth_2_properties.zig").OAuth2Properties;

/// A structure containing the authentication configuration.
pub const AuthenticationConfiguration = struct {
    /// A structure containing the authentication configuration.
    authentication_type: ?AuthenticationType,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt sensitive
    /// authentication information. This key is used to protect credentials
    /// and other sensitive data stored within the authentication configuration.
    kms_key_arn: ?[]const u8,

    /// The properties for OAuth2 authentication.
    o_auth_2_properties: ?OAuth2Properties,

    /// The secret manager ARN to store credentials.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .kms_key_arn = "KmsKeyArn",
        .o_auth_2_properties = "OAuth2Properties",
        .secret_arn = "SecretArn",
    };
};
