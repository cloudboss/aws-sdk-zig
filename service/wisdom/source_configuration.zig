const AppIntegrationsConfiguration = @import("app_integrations_configuration.zig").AppIntegrationsConfiguration;

/// Configuration information about the external data source.
pub const SourceConfiguration = union(enum) {
    /// Configuration information for Amazon AppIntegrations to automatically ingest
    /// content.
    app_integrations: ?AppIntegrationsConfiguration,

    pub const json_field_names = .{
        .app_integrations = "appIntegrations",
    };
};
