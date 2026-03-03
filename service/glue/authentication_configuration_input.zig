const aws = @import("aws");

const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const BasicAuthenticationCredentials = @import("basic_authentication_credentials.zig").BasicAuthenticationCredentials;
const OAuth2PropertiesInput = @import("o_auth_2_properties_input.zig").OAuth2PropertiesInput;

/// A structure containing the authentication configuration in the
/// CreateConnection request.
pub const AuthenticationConfigurationInput = struct {
    /// A structure containing the authentication configuration in the
    /// CreateConnection request.
    authentication_type: ?AuthenticationType = null,

    /// The credentials used when the authentication type is basic authentication.
    basic_authentication_credentials: ?BasicAuthenticationCredentials = null,

    /// The credentials used when the authentication type is custom authentication.
    custom_authentication_credentials: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the KMS key used to encrypt the connection. Only taken an as
    /// input in the request and stored in the Secret Manager.
    kms_key_arn: ?[]const u8 = null,

    /// The properties for OAuth2 authentication in the CreateConnection request.
    o_auth_2_properties: ?OAuth2PropertiesInput = null,

    /// The secret manager ARN to store credentials in the CreateConnection request.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .basic_authentication_credentials = "BasicAuthenticationCredentials",
        .custom_authentication_credentials = "CustomAuthenticationCredentials",
        .kms_key_arn = "KmsKeyArn",
        .o_auth_2_properties = "OAuth2Properties",
        .secret_arn = "SecretArn",
    };
};
