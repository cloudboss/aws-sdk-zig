const AuthorizationConfiguration = @import("authorization_configuration.zig").AuthorizationConfiguration;

/// Configurations related to the security configuration for the request.
pub const SecurityConfigurationData = struct {
    /// Authorization-related configuration input for the security configuration.
    authorization_configuration: ?AuthorizationConfiguration,

    pub const json_field_names = .{
        .authorization_configuration = "authorizationConfiguration",
    };
};
