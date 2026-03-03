const JwtValidationActionAdditionalClaim = @import("jwt_validation_action_additional_claim.zig").JwtValidationActionAdditionalClaim;

/// Information about a JSON Web Token (JWT) validation action.
pub const JwtValidationActionConfig = struct {
    /// Additional claims to validate. The maximum size of the list is 10.
    /// We validate the `exp`, `iss`, `nbf`,
    /// and `iat` claims by default.
    additional_claims: ?[]const JwtValidationActionAdditionalClaim = null,

    /// The issuer of the JWT. The maximum length is 256 characters.
    issuer: []const u8,

    /// The JSON Web Key Set (JWKS) endpoint. This endpoint contains JSON Web Keys
    /// (JWK)
    /// that are used to validate signatures from the provider.
    ///
    /// This must be a full URL, including the HTTPS protocol, the domain, and the
    /// path.
    /// The maximum length is 256 characters.
    jwks_endpoint: []const u8,
};
