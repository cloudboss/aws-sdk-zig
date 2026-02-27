/// An authorization token data object that corresponds to a public registry.
pub const AuthorizationData = struct {
    /// A base64-encoded string that contains authorization data for a public Amazon
    /// ECR registry.
    /// When the string is decoded, it's presented in the format `user:password` for
    /// public registry authentication using `docker login`.
    authorization_token: ?[]const u8,

    /// The Unix time in seconds and milliseconds when the authorization token
    /// expires.
    /// Authorization tokens are valid for 12 hours.
    expires_at: ?i64,

    pub const json_field_names = .{
        .authorization_token = "authorizationToken",
        .expires_at = "expiresAt",
    };
};
