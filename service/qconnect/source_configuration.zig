const AppIntegrationsConfiguration = @import("app_integrations_configuration.zig").AppIntegrationsConfiguration;
const ManagedSourceConfiguration = @import("managed_source_configuration.zig").ManagedSourceConfiguration;

/// Configuration information about the external data source.
pub const SourceConfiguration = union(enum) {
    /// Configuration information for Amazon AppIntegrations to automatically ingest
    /// content.
    app_integrations: ?AppIntegrationsConfiguration,
    /// Source configuration for managed resources.
    managed_source_configuration: ?ManagedSourceConfiguration,

    pub const json_field_names = .{
        .app_integrations = "appIntegrations",
        .managed_source_configuration = "managedSourceConfiguration",
    };
};
