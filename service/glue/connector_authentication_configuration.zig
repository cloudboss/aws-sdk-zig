const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const BasicAuthenticationProperties = @import("basic_authentication_properties.zig").BasicAuthenticationProperties;
const CustomAuthenticationProperties = @import("custom_authentication_properties.zig").CustomAuthenticationProperties;
const ConnectorOAuth2Properties = @import("connector_o_auth_2_properties.zig").ConnectorOAuth2Properties;

/// Configuration that defines the supported authentication types and required
/// properties for the connection type.
pub const ConnectorAuthenticationConfiguration = struct {
    /// A list of authentication types supported by this connection type, such as
    /// Basic, OAuth2, or Custom authentication methods.
    authentication_types: []const AuthenticationType,

    basic_authentication_properties: ?BasicAuthenticationProperties = null,

    custom_authentication_properties: ?CustomAuthenticationProperties = null,

    o_auth_2_properties: ?ConnectorOAuth2Properties = null,

    pub const json_field_names = .{
        .authentication_types = "AuthenticationTypes",
        .basic_authentication_properties = "BasicAuthenticationProperties",
        .custom_authentication_properties = "CustomAuthenticationProperties",
        .o_auth_2_properties = "OAuth2Properties",
    };
};
