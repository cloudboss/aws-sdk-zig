const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const OAuth2Properties = @import("o_auth_2_properties.zig").OAuth2Properties;

/// The authentication configuration of a connection.
pub const AuthenticationConfiguration = struct {
    /// The authentication type of a connection.
    authentication_type: ?AuthenticationType,

    /// The oAuth2 properties of a connection.
    o_auth_2_properties: ?OAuth2Properties,

    /// The secret ARN of a connection.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .authentication_type = "authenticationType",
        .o_auth_2_properties = "oAuth2Properties",
        .secret_arn = "secretArn",
    };
};
