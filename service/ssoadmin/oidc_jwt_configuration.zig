const JwksRetrievalOption = @import("jwks_retrieval_option.zig").JwksRetrievalOption;

/// A structure that describes configuration settings for a trusted token issuer
/// that supports OpenID Connect (OIDC) and JSON Web Tokens (JWTs).
pub const OidcJwtConfiguration = struct {
    /// The path of the source attribute in the JWT from the trusted token issuer.
    /// The attribute mapped by this JMESPath expression is compared against the
    /// attribute mapped by `IdentityStoreAttributePath` when a trusted token issuer
    /// token is exchanged for an IAM Identity Center token.
    claim_attribute_path: []const u8,

    /// The path of the destination attribute in a JWT from IAM Identity Center. The
    /// attribute mapped by this JMESPath expression is compared against the
    /// attribute mapped by `ClaimAttributePath` when a trusted token issuer token
    /// is exchanged for an IAM Identity Center token.
    identity_store_attribute_path: []const u8,

    /// The URL that IAM Identity Center uses for OpenID Discovery. OpenID Discovery
    /// is used to obtain the information required to verify the tokens that the
    /// trusted token issuer generates.
    issuer_url: []const u8,

    /// The method that the trusted token issuer can use to retrieve the JSON Web
    /// Key Set used to verify a JWT.
    jwks_retrieval_option: JwksRetrievalOption,

    pub const json_field_names = .{
        .claim_attribute_path = "ClaimAttributePath",
        .identity_store_attribute_path = "IdentityStoreAttributePath",
        .issuer_url = "IssuerUrl",
        .jwks_retrieval_option = "JwksRetrievalOption",
    };
};
