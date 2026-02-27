const WebhookAuthenticationType = @import("webhook_authentication_type.zig").WebhookAuthenticationType;
const WebhookAuthConfiguration = @import("webhook_auth_configuration.zig").WebhookAuthConfiguration;
const WebhookFilterRule = @import("webhook_filter_rule.zig").WebhookFilterRule;

/// Represents information about a webhook and its definition.
pub const WebhookDefinition = struct {
    /// Supported options are GITHUB_HMAC, IP, and UNAUTHENTICATED.
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
    ///
    /// * For information about the authentication scheme implemented by
    ///   GITHUB_HMAC,
    /// see [Securing your
    /// webhooks](https://developer.github.com/webhooks/securing/) on the GitHub
    /// Developer website.
    ///
    /// * IP rejects webhooks trigger requests unless they originate from an IP
    /// address in the IP range whitelisted in the authentication
    /// configuration.
    ///
    /// * UNAUTHENTICATED accepts all webhook trigger requests regardless of
    /// origin.
    authentication: WebhookAuthenticationType,

    /// Properties that configure the authentication applied to incoming webhook
    /// trigger
    /// requests. The required properties depend on the authentication type. For
    /// GITHUB_HMAC,
    /// only the `SecretToken `property must be set. For IP, only the
    /// `AllowedIPRange `property must be set to a valid CIDR range. For
    /// UNAUTHENTICATED, no properties can be set.
    authentication_configuration: WebhookAuthConfiguration,

    /// A list of rules applied to the body/payload sent in the POST request to a
    /// webhook
    /// URL. All defined rules must pass for the request to be accepted and the
    /// pipeline
    /// started.
    filters: []const WebhookFilterRule,

    /// The name of the webhook.
    name: []const u8,

    /// The name of the action in a pipeline you want to connect to the webhook. The
    /// action
    /// must be from the source (first) stage of the pipeline.
    target_action: []const u8,

    /// The name of the pipeline you want to connect to the webhook.
    target_pipeline: []const u8,

    pub const json_field_names = .{
        .authentication = "authentication",
        .authentication_configuration = "authenticationConfiguration",
        .filters = "filters",
        .name = "name",
        .target_action = "targetAction",
        .target_pipeline = "targetPipeline",
    };
};
