const BasicAuth = @import("basic_auth.zig").BasicAuth;

/// Union type representing different proxy authentication methods. Currently
/// supports HTTP Basic Authentication (username and password).
pub const ProxyCredentials = union(enum) {
    /// HTTP Basic Authentication credentials (username and password) stored in
    /// Amazon Web Services Secrets Manager.
    basic_auth: ?BasicAuth,

    pub const json_field_names = .{
        .basic_auth = "basicAuth",
    };
};
