const aws = @import("aws");

/// An object representing an OpenID Connect (OIDC) configuration. Before
/// associating an
/// OIDC identity provider to your cluster, review the considerations in
/// [Authenticating
/// users for your cluster from an OIDC identity
/// provider](https://docs.aws.amazon.com/eks/latest/userguide/authenticate-oidc-identity-provider.html) in the
/// *Amazon EKS User Guide*.
pub const OidcIdentityProviderConfigRequest = struct {
    /// This is also known as *audience*. The ID for the client application
    /// that makes authentication requests to the OIDC identity provider.
    client_id: []const u8,

    /// The JWT claim that the provider uses to return your groups.
    groups_claim: ?[]const u8 = null,

    /// The prefix that is prepended to group claims to prevent clashes with
    /// existing names
    /// (such as `system:` groups). For example, the value` oidc:` will
    /// create group names like `oidc:engineering` and
    /// `oidc:infra`.
    groups_prefix: ?[]const u8 = null,

    /// The name of the OIDC provider configuration.
    identity_provider_config_name: []const u8,

    /// The URL of the OIDC identity provider that allows the API server to discover
    /// public
    /// signing keys for verifying tokens. The URL must begin with `https://` and
    /// should correspond to the `iss` claim in the provider's OIDC ID tokens.
    /// Based on the OIDC standard, path components are allowed but query parameters
    /// are not.
    /// Typically the URL consists of only a hostname, like
    /// `https://server.example.org` or `https://example.com`. This
    /// URL should point to the level below `.well-known/openid-configuration` and
    /// must be publicly accessible over the internet.
    issuer_url: []const u8,

    /// The key value pairs that describe required claims in the identity token. If
    /// set, each
    /// claim is verified to be present in the token with a matching value. For the
    /// maximum
    /// number of claims that you can require, see [Amazon EKS service
    /// quotas](https://docs.aws.amazon.com/eks/latest/userguide/service-quotas.html) in the
    /// *Amazon EKS User Guide*.
    required_claims: ?[]const aws.map.StringMapEntry = null,

    /// The JSON Web Token (JWT) claim to use as the username. The default is
    /// `sub`, which is expected to be a unique identifier of the end user. You can
    /// choose other claims, such as `email` or `name`, depending on the
    /// OIDC identity provider. Claims other than `email` are prefixed with the
    /// issuer URL to prevent naming clashes with other plug-ins.
    username_claim: ?[]const u8 = null,

    /// The prefix that is prepended to username claims to prevent clashes with
    /// existing
    /// names. If you do not provide this field, and `username` is a value other
    /// than
    /// `email`, the prefix defaults to `issuerurl#`. You can use the
    /// value `-` to disable all prefixing.
    username_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .groups_claim = "groupsClaim",
        .groups_prefix = "groupsPrefix",
        .identity_provider_config_name = "identityProviderConfigName",
        .issuer_url = "issuerUrl",
        .required_claims = "requiredClaims",
        .username_claim = "usernameClaim",
        .username_prefix = "usernamePrefix",
    };
};
