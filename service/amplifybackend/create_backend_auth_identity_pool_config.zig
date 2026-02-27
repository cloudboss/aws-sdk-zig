/// Describes authorization configurations for the auth resources, configured as
/// a part of your Amplify project.
pub const CreateBackendAuthIdentityPoolConfig = struct {
    /// Name of the Amazon Cognito identity pool used for authorization.
    identity_pool_name: []const u8,

    /// Set to true or false based on whether you want to enable guest authorization
    /// to your Amplify app.
    unauthenticated_login: bool,

    pub const json_field_names = .{
        .identity_pool_name = "IdentityPoolName",
        .unauthenticated_login = "UnauthenticatedLogin",
    };
};
