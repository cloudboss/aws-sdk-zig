const ResourceServerScopeType = @import("resource_server_scope_type.zig").ResourceServerScopeType;

/// The details of a resource server configuration and associated custom scopes
/// in a user
/// pool.
pub const ResourceServerType = struct {
    /// A unique resource server identifier for the resource server. The identifier
    /// can be an
    /// API friendly name like `solar-system-data`. You can also set an API URL like
    /// `https://solar-system-data-api.example.com` as your identifier.
    ///
    /// Amazon Cognito represents scopes in the access token in the format
    /// `$resource-server-identifier/$scope`. Longer scope-identifier strings
    /// increase the size of your access tokens.
    identifier: ?[]const u8 = null,

    /// The name of the resource server.
    name: ?[]const u8 = null,

    /// A list of scopes that are defined for the resource server.
    scopes: ?[]const ResourceServerScopeType = null,

    /// The ID of the user pool that contains the resource server configuration.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .name = "Name",
        .scopes = "Scopes",
        .user_pool_id = "UserPoolId",
    };
};
