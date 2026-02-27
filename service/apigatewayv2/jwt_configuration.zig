/// Represents the configuration of a JWT authorizer. Required for the JWT
/// authorizer type. Supported only for HTTP APIs.
pub const JWTConfiguration = struct {
    /// A list of the intended recipients of the JWT. A valid JWT must provide an
    /// aud that matches at least one entry in this list. See [RFC
    /// 7519](https://tools.ietf.org/html/rfc7519#section-4.1.3). Supported only for
    /// HTTP APIs.
    audience: ?[]const []const u8,

    /// The base domain of the identity provider that issues JSON Web Tokens. For
    /// example, an Amazon Cognito user pool has the following format:
    /// https://cognito-idp.{region}.amazonaws.com/{userPoolId}
    /// . Required for the JWT authorizer type. Supported only for HTTP APIs.
    issuer: ?[]const u8,

    pub const json_field_names = .{
        .audience = "Audience",
        .issuer = "Issuer",
    };
};
