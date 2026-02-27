const AuthResources = @import("auth_resources.zig").AuthResources;
const CreateBackendAuthIdentityPoolConfig = @import("create_backend_auth_identity_pool_config.zig").CreateBackendAuthIdentityPoolConfig;
const Service = @import("service.zig").Service;
const CreateBackendAuthUserPoolConfig = @import("create_backend_auth_user_pool_config.zig").CreateBackendAuthUserPoolConfig;

/// Defines the resource configuration when creating an auth resource in your
/// Amplify project.
pub const CreateBackendAuthResourceConfig = struct {
    /// Defines whether you want to configure only authentication or both
    /// authentication and authorization settings.
    auth_resources: AuthResources,

    /// Describes the authorization configuration for the Amazon Cognito identity
    /// pool, provisioned as a part of your auth resource in the Amplify project.
    identity_pool_configs: ?CreateBackendAuthIdentityPoolConfig,

    /// Defines the service name to use when configuring an authentication resource
    /// in your Amplify project.
    service: Service,

    /// Describes authentication configuration for the Amazon Cognito user pool,
    /// provisioned as a part of your auth resource in the Amplify project.
    user_pool_configs: CreateBackendAuthUserPoolConfig,

    pub const json_field_names = .{
        .auth_resources = "AuthResources",
        .identity_pool_configs = "IdentityPoolConfigs",
        .service = "Service",
        .user_pool_configs = "UserPoolConfigs",
    };
};
