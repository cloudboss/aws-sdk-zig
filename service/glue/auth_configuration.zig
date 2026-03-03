const aws = @import("aws");

const Property = @import("property.zig").Property;

/// The authentication configuration for a connection returned by the
/// `DescribeConnectionType` API.
pub const AuthConfiguration = struct {
    /// The type of authentication for a connection.
    authentication_type: Property,

    /// A map of key-value pairs for the OAuth2 properties. Each value is a a
    /// `Property` object.
    basic_authentication_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// A map of key-value pairs for the custom authentication properties. Each
    /// value is a a `Property` object.
    custom_authentication_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// A map of key-value pairs for the OAuth2 properties. Each value is a a
    /// `Property` object.
    o_auth_2_properties: ?[]const aws.map.MapEntry(Property) = null,

    /// The Amazon Resource Name (ARN) for the Secrets Manager.
    secret_arn: ?Property = null,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .basic_authentication_properties = "BasicAuthenticationProperties",
        .custom_authentication_properties = "CustomAuthenticationProperties",
        .o_auth_2_properties = "OAuth2Properties",
        .secret_arn = "SecretArn",
    };
};
