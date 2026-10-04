const AzureConnectorConfiguration = @import("azure_connector_configuration.zig").AzureConnectorConfiguration;

/// The provider-specific configuration for connecting to the third-party cloud
/// service provider. You must specify exactly one provider configuration.
pub const ConnectorConfiguration = struct {
    /// The configuration for an Azure connector.
    azure: ?AzureConnectorConfiguration = null,

    pub const json_field_names = .{
        .azure = "azure",
    };
};
