/// Describes the IAM SAML identity providers used for federated authentication.
pub const FederatedAuthentication = struct {
    /// The Amazon Resource Name (ARN) of the IAM SAML identity provider.
    saml_provider_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM SAML identity provider for the
    /// self-service portal.
    self_service_saml_provider_arn: ?[]const u8,
};
