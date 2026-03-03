const aws = @import("aws");

const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const BasicAuthenticationCredentials = @import("basic_authentication_credentials.zig").BasicAuthenticationCredentials;
const OAuth2Properties = @import("o_auth_2_properties.zig").OAuth2Properties;

/// The authentication configuration of a connection.
pub const AuthenticationConfigurationInput = struct {
    /// The authentication type of a connection.
    authentication_type: ?AuthenticationType = null,

    /// The basic authentication credentials of a connection.
    basic_authentication_credentials: ?BasicAuthenticationCredentials = null,

    /// The custom authentication credentials of a connection.
    custom_authentication_credentials: ?[]const aws.map.StringMapEntry = null,

    /// The KMS key ARN of a connection.
    kms_key_arn: ?[]const u8 = null,

    /// The oAuth2 properties of a connection.
    o_auth_2_properties: ?OAuth2Properties = null,

    /// The secret ARN of a connection.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_type = "authenticationType",
        .basic_authentication_credentials = "basicAuthenticationCredentials",
        .custom_authentication_credentials = "customAuthenticationCredentials",
        .kms_key_arn = "kmsKeyArn",
        .o_auth_2_properties = "oAuth2Properties",
        .secret_arn = "secretArn",
    };
};
