/// Configuration for external Identity Provider OIDC authentication flow for
/// the Operator App.
pub const IdpAuthConfiguration = struct {
    /// The OIDC client ID for the IdP application
    client_id: []const u8,

    /// The timestamp when the Operator App IdP auth flow was enabled.
    created_at: i64,

    /// The OIDC issuer URL of the external Identity Provider
    issuer_url: []const u8,

    /// The IAM role end users assume to access AIDevOps APIs
    operator_app_role_arn: []const u8,

    /// The Identity Provider name (e.g., Entra, Okta, Google)
    provider: []const u8,

    /// The timestamp when the Operator App IdP auth flow was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .created_at = "createdAt",
        .issuer_url = "issuerUrl",
        .operator_app_role_arn = "operatorAppRoleArn",
        .provider = "provider",
        .updated_at = "updatedAt",
    };
};
