const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const ConnectorProviderName = @import("connector_provider_name.zig").ConnectorProviderName;

/// The connectorV2 third-party provider configuration summary.
pub const ProviderSummary = struct {
    /// The status for the connectorV2.
    connector_status: ?ConnectorStatus,

    /// The name of the provider.
    provider_name: ?ConnectorProviderName,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .provider_name = "ProviderName",
    };
};
