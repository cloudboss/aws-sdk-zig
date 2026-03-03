const ConnectorProperty = @import("connector_property.zig").ConnectorProperty;

/// Basic authentication configuration that defines the username and password
/// properties for HTTP Basic authentication.
pub const BasicAuthenticationProperties = struct {
    /// The password property name to use for Basic authentication credentials.
    password: ?ConnectorProperty = null,

    /// The username property name to use for Basic authentication credentials.
    username: ?ConnectorProperty = null,

    pub const json_field_names = .{
        .password = "Password",
        .username = "Username",
    };
};
