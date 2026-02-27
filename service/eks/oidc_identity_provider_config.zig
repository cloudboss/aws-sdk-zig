const aws = @import("aws");

const configStatus = @import("config_status.zig").configStatus;

/// An object representing the configuration for an OpenID Connect (OIDC)
/// identity provider.
pub const OidcIdentityProviderConfig = struct {
    /// This is also known as *audience*. The ID of the client application
    /// that makes authentication requests to the OIDC identity provider.
    client_id: ?[]const u8,

    /// The name of your cluster.
    cluster_name: ?[]const u8,

    /// The JSON web token (JWT) claim that the provider uses to return your groups.
    groups_claim: ?[]const u8,

    /// The prefix that is prepended to group claims to prevent clashes with
    /// existing names
    /// (such as `system:` groups). For example, the value` oidc:` creates
    /// group names like `oidc:engineering` and `oidc:infra`. The prefix
    /// can't contain `system:`
    groups_prefix: ?[]const u8,

    /// The ARN of the configuration.
    identity_provider_config_arn: ?[]const u8,

    /// The name of the configuration.
    identity_provider_config_name: ?[]const u8,

    /// The URL of the OIDC identity provider that allows the API server to discover
    /// public
    /// signing keys for verifying tokens.
    issuer_url: ?[]const u8,

    /// The key-value pairs that describe required claims in the identity token. If
    /// set, each
    /// claim is verified to be present in the token with a matching value.
    required_claims: ?[]const aws.map.StringMapEntry,

    /// The status of the OIDC identity provider.
    status: ?configStatus,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry,

    /// The JSON Web token (JWT) claim that is used as the username.
    username_claim: ?[]const u8,

    /// The prefix that is prepended to username claims to prevent clashes with
    /// existing
    /// names. The prefix can't contain `system:`
    username_prefix: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .cluster_name = "clusterName",
        .groups_claim = "groupsClaim",
        .groups_prefix = "groupsPrefix",
        .identity_provider_config_arn = "identityProviderConfigArn",
        .identity_provider_config_name = "identityProviderConfigName",
        .issuer_url = "issuerUrl",
        .required_claims = "requiredClaims",
        .status = "status",
        .tags = "tags",
        .username_claim = "usernameClaim",
        .username_prefix = "usernamePrefix",
    };
};
