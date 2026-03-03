/// Describes the authorization configuration for the Amazon Cognito identity
/// pool, provisioned as a part of your auth resource in the Amplify project.
pub const UpdateBackendAuthIdentityPoolConfig = struct {
    /// A boolean value that can be set to allow or disallow guest-level
    /// authorization into your Amplify app.
    unauthenticated_login: ?bool = null,

    pub const json_field_names = .{
        .unauthenticated_login = "UnauthenticatedLogin",
    };
};
