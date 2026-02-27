const WebhookScopeType = @import("webhook_scope_type.zig").WebhookScopeType;

/// Contains configuration information about the scope for a webhook.
pub const ScopeConfiguration = struct {
    /// The domain of the GitHub Enterprise organization or the GitLab Self Managed
    /// group. Note that this parameter is only required if your project's source
    /// type is GITHUB_ENTERPRISE or GITLAB_SELF_MANAGED.
    domain: ?[]const u8,

    /// The name of either the group, enterprise, or organization that will send
    /// webhook events to CodeBuild, depending on the type of webhook.
    name: []const u8,

    /// The type of scope for a GitHub or GitLab webhook. The scope default is
    /// GITHUB_ORGANIZATION.
    scope: WebhookScopeType,

    pub const json_field_names = .{
        .domain = "domain",
        .name = "name",
        .scope = "scope",
    };
};
