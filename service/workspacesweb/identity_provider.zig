const aws = @import("aws");

const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;

/// The identity provider.
pub const IdentityProvider = struct {
    /// The ARN of the identity provider.
    identity_provider_arn: []const u8,

    /// The identity provider details. The following list describes the provider
    /// detail keys for each identity provider type.
    ///
    /// * For Google and Login with Amazon:
    ///
    /// * `client_id`
    /// * `client_secret`
    /// * `authorize_scopes`
    ///
    /// * For Facebook:
    ///
    /// * `client_id`
    /// * `client_secret`
    /// * `authorize_scopes`
    /// * `api_version`
    ///
    /// * For Sign in with Apple:
    ///
    /// * `client_id`
    /// * `team_id`
    /// * `key_id`
    /// * `private_key`
    /// * `authorize_scopes`
    ///
    /// * For OIDC providers:
    ///
    /// * `client_id`
    /// * `client_secret`
    /// * `attributes_request_method`
    /// * `oidc_issuer`
    /// * `authorize_scopes`
    /// * `authorize_url` *if not available from discovery URL specified by
    ///   oidc_issuer key*
    /// * `token_url` *if not available from discovery URL specified by oidc_issuer
    ///   key*
    /// * `attributes_url` *if not available from discovery URL specified by
    ///   oidc_issuer key*
    /// * `jwks_uri` *if not available from discovery URL specified by oidc_issuer
    ///   key*
    ///
    /// * For SAML providers:
    ///
    /// * `MetadataFile` OR `MetadataURL`
    /// * `IDPSignout` (boolean) *optional*
    /// * `IDPInit` (boolean) *optional*
    /// * `RequestSigningAlgorithm` (string) *optional* - Only accepts `rsa-sha256`
    /// * `EncryptedResponses` (boolean) *optional*
    identity_provider_details: ?[]const aws.map.StringMapEntry = null,

    /// The identity provider name.
    identity_provider_name: ?[]const u8 = null,

    /// The identity provider type.
    identity_provider_type: ?IdentityProviderType = null,

    pub const json_field_names = .{
        .identity_provider_arn = "identityProviderArn",
        .identity_provider_details = "identityProviderDetails",
        .identity_provider_name = "identityProviderName",
        .identity_provider_type = "identityProviderType",
    };
};
