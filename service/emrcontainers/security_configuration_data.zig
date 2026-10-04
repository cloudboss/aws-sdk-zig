const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const AuthorizationConfiguration = @import("authorization_configuration.zig").AuthorizationConfiguration;

/// Configurations related to the security configuration for the request.
pub const SecurityConfigurationData = struct {
    /// Authentication-related configuration input for the security configuration.
    authentication_configuration: ?AuthenticationConfiguration = null,

    /// Authorization-related configuration input for the security configuration.
    authorization_configuration: ?AuthorizationConfiguration = null,

    pub const json_field_names = .{
        .authentication_configuration = "authenticationConfiguration",
        .authorization_configuration = "authorizationConfiguration",
    };
};
