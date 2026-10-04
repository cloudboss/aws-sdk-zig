/// The configuration details for connecting to Microsoft Azure.
pub const AzureConnectorConfiguration = struct {
    /// The Azure client identifier.
    client_identifier: []const u8,

    /// The Azure tenant identifier.
    tenant_identifier: []const u8,

    pub const json_field_names = .{
        .client_identifier = "clientIdentifier",
        .tenant_identifier = "tenantIdentifier",
    };
};
