const JwtSigningAlgorithm = @import("jwt_signing_algorithm.zig").JwtSigningAlgorithm;

/// Details for SASL/OAUTHBEARER using JWT Bearer assertion grant.
pub const KafkaClusterOAuthIamJwtBearer = struct {
    /// The audience for the JWT Bearer assertion.
    audience: []const u8,

    /// The signing algorithm for the JWT Bearer assertion.
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
