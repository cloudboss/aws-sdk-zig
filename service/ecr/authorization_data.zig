/// An object representing authorization data for an Amazon ECR registry.
pub const AuthorizationData = struct {
    /// A base64-encoded string that contains authorization data for the specified
    /// Amazon ECR
    /// registry. When the string is decoded, it is presented in the format
    /// `user:password` for private registry authentication using `docker
    /// login`.
    authorization_token: ?[]const u8 = null,

    /// The Unix time in seconds and milliseconds when the authorization token
    /// expires.
    /// Authorization tokens are valid for 12 hours.
    expires_at: ?i64 = null,

    /// The registry URL to use for this authorization token in a `docker login`
    /// command. The Amazon ECR registry URL format is
    /// `https://aws_account_id.dkr.ecr.region.amazonaws.com`. For example,
    /// `https://012345678910.dkr.ecr.us-east-1.amazonaws.com`..
    proxy_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_token = "authorizationToken",
        .expires_at = "expiresAt",
        .proxy_endpoint = "proxyEndpoint",
    };
};
