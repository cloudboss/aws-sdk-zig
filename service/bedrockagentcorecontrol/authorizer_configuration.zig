const CustomJWTAuthorizerConfiguration = @import("custom_jwt_authorizer_configuration.zig").CustomJWTAuthorizerConfiguration;

/// Represents inbound authorization configuration options used to authenticate
/// incoming requests.
pub const AuthorizerConfiguration = union(enum) {
    /// The inbound JWT-based authorization, specifying how incoming requests should
    /// be authenticated.
    custom_jwt_authorizer: ?CustomJWTAuthorizerConfiguration,

    pub const json_field_names = .{
        .custom_jwt_authorizer = "customJWTAuthorizer",
    };
};
