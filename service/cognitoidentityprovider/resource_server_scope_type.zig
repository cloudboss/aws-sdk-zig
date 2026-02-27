/// One custom scope associated with a user pool resource server. This data type
/// is a
/// member of `ResourceServerScopeType`. For more information, see [
/// Scopes, M2M, and API authorization with resource
/// servers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-define-resource-servers.html).
pub const ResourceServerScopeType = struct {
    /// A friendly description of a custom scope.
    scope_description: []const u8,

    /// The name of the scope. Amazon Cognito renders custom scopes in the format
    /// `resourceServerIdentifier/ScopeName`. For example, if this parameter is
    /// `exampleScope` in the resource server with the identifier
    /// `exampleResourceServer`, you request and receive the scope
    /// `exampleResourceServer/exampleScope`.
    scope_name: []const u8,

    pub const json_field_names = .{
        .scope_description = "ScopeDescription",
        .scope_name = "ScopeName",
    };
};
