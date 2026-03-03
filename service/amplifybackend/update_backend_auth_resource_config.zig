const AuthResources = @import("auth_resources.zig").AuthResources;
const UpdateBackendAuthIdentityPoolConfig = @import("update_backend_auth_identity_pool_config.zig").UpdateBackendAuthIdentityPoolConfig;
const Service = @import("service.zig").Service;
const UpdateBackendAuthUserPoolConfig = @import("update_backend_auth_user_pool_config.zig").UpdateBackendAuthUserPoolConfig;

/// Defines the resource configuration when updating an authentication resource
/// in your Amplify project.
pub const UpdateBackendAuthResourceConfig = struct {
    /// Defines the service name to use when configuring an authentication resource
    /// in your Amplify project.
    auth_resources: AuthResources,

    /// Describes the authorization configuration for the Amazon Cognito identity
    /// pool, provisioned as a part of your auth resource in the Amplify project.
    identity_pool_configs: ?UpdateBackendAuthIdentityPoolConfig = null,

    /// Defines the service name to use when configuring an authentication resource
    /// in your Amplify project.
    service: Service,

    /// Describes the authentication configuration for the Amazon Cognito user pool,
    /// provisioned as a part of your auth resource in the Amplify project.
    user_pool_configs: UpdateBackendAuthUserPoolConfig,

    pub const json_field_names = .{
        .auth_resources = "AuthResources",
        .identity_pool_configs = "IdentityPoolConfigs",
        .service = "Service",
        .user_pool_configs = "UserPoolConfigs",
    };
};
