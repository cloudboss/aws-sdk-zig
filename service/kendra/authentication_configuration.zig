const BasicAuthenticationConfiguration = @import("basic_authentication_configuration.zig").BasicAuthenticationConfiguration;

/// Provides the configuration information to connect to websites that require
/// user
/// authentication.
pub const AuthenticationConfiguration = struct {
    /// The list of configuration information that's required to connect to and
    /// crawl a
    /// website host using basic authentication credentials.
    ///
    /// The list includes the name and port number of the website host.
    basic_authentication: ?[]const BasicAuthenticationConfiguration = null,

    pub const json_field_names = .{
        .basic_authentication = "BasicAuthentication",
    };
};
