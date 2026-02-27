/// The authentication applied to incoming webhook trigger requests.
pub const WebhookAuthConfiguration = struct {
    /// The property used to configure acceptance of webhooks in an IP address
    /// range. For
    /// IP, only the `AllowedIPRange` property must be set. This property must be
    /// set
    /// to a valid CIDR range.
    allowed_ip_range: ?[]const u8,

    /// The property used to configure GitHub authentication. For GITHUB_HMAC, only
    /// the
    /// `SecretToken` property must be set.
    ///
    /// When creating CodePipeline webhooks, do not use your own credentials or
    /// reuse the same secret token across multiple webhooks. For optimal security,
    /// generate
    /// a unique secret token for each webhook you create. The secret token is an
    /// arbitrary
    /// string that you provide, which GitHub uses to compute and sign the webhook
    /// payloads
    /// sent to CodePipeline, for protecting the integrity and authenticity of the
    /// webhook payloads. Using your own credentials or reusing the same token
    /// across
    /// multiple webhooks can lead to security vulnerabilities.
    ///
    /// If a secret token was provided, it will be redacted in the response.
    secret_token: ?[]const u8,

    pub const json_field_names = .{
        .allowed_ip_range = "AllowedIPRange",
        .secret_token = "SecretToken",
    };
};
