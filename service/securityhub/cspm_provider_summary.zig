const CspmConnectorStatus = @import("cspm_connector_status.zig").CspmConnectorStatus;
const CspmProviderDetail = @import("cspm_provider_detail.zig").CspmProviderDetail;
const CspmConnectorProviderName = @import("cspm_connector_provider_name.zig").CspmConnectorProviderName;

/// A summary of the cloud provider configuration for a connector.
pub const CspmProviderSummary = struct {
    /// The connectivity status of the connector.
    connector_status: ?CspmConnectorStatus = null,

    /// The provider configuration details.
    provider_configuration: ?CspmProviderDetail = null,

    /// The name of the cloud provider.
    provider_name: ?CspmConnectorProviderName = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .provider_configuration = "ProviderConfiguration",
        .provider_name = "ProviderName",
    };
};
