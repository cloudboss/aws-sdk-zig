const AuthParameter = @import("auth_parameter.zig").AuthParameter;

/// Configuration information required for custom authentication.
pub const CustomAuthConfig = struct {
    /// Information about authentication parameters required for authentication.
    auth_parameters: ?[]const AuthParameter,

    /// The authentication type that the custom connector uses.
    custom_authentication_type: ?[]const u8,

    pub const json_field_names = .{
        .auth_parameters = "authParameters",
        .custom_authentication_type = "customAuthenticationType",
    };
};
