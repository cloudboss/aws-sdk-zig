const JwtSigningAlgorithm = @import("jwt_signing_algorithm.zig").JwtSigningAlgorithm;

/// Details for SASL/OAUTHBEARER using client credentials grant with JWT client
/// assertion.
pub const KafkaClusterOAuthClientCredentialsAssertion = struct {
    /// The audience for the JWT client assertion.
    audience: []const u8,

    /// The signing algorithm for the JWT client assertion.
    signing_algorithm: JwtSigningAlgorithm,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret containing the
    /// signing key.
    token_request_secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .audience = "Audience",
        .signing_algorithm = "SigningAlgorithm",
        .token_request_secret_arn = "TokenRequestSecretArn",
    };
};
