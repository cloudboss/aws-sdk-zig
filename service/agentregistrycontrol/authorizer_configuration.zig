const CustomJWTAuthorizerConfiguration = @import("custom_jwt_authorizer_configuration.zig").CustomJWTAuthorizerConfiguration;

/// The authorizer configuration for a registry. Exactly one member is set.
pub const AuthorizerConfiguration = union(enum) {
    /// Configuration for a custom JWT authorizer.
    custom_jwt_authorizer: ?CustomJWTAuthorizerConfiguration,

    pub const json_field_names = .{
        .custom_jwt_authorizer = "customJWTAuthorizer",
    };
};
