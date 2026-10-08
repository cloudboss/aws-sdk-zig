const Provider = @import("provider.zig").Provider;
const ProviderType = @import("provider_type.zig").ProviderType;

/// Contains summary information about an integration.
pub const IntegrationSummary = struct {
    /// The display name of the integration.
    display_name: []const u8,

    /// The installation identifier from the integration provider.
    installation_id: []const u8,

    /// The unique identifier of the integration.
    integration_id: []const u8,

    /// The name of the private connection used to reach the integration's
    /// self-hosted instance over private networking, if one is configured.
    private_connection_name: ?[]const u8 = null,

    /// The integration provider.
    provider: Provider,

    /// The type of the integration provider.
    provider_type: ProviderType,

    /// The HTTPS URL of the customer self-hosted instance, such as a GitHub
    /// Enterprise Server or self-managed GitLab instance. This value is absent for
    /// SaaS integrations.
    target_url: ?[]const u8 = null,

    /// The payload URL of the integration's webhook, once it has been created. The
    /// signing secret is never returned on a read.
    webhook_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .installation_id = "installationId",
        .integration_id = "integrationId",
        .private_connection_name = "privateConnectionName",
        .provider = "provider",
        .provider_type = "providerType",
        .target_url = "targetUrl",
        .webhook_url = "webhookUrl",
    };
};
