const CspmEnablementStatus = @import("cspm_enablement_status.zig").CspmEnablementStatus;
const CspmProviderSummary = @import("cspm_provider_summary.zig").CspmProviderSummary;

/// A summary of a CSPM connector.
pub const CspmConnectorSummary = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The unique identifier of the connector.
    connector_id: ?[]const u8 = null,

    /// The ISO 8601 UTC timestamp indicating when the connector was created.
    created_at: ?i64 = null,

    /// The service principal that created the connector.
    created_by: ?[]const u8 = null,

    /// The description of the connector.
    description: ?[]const u8 = null,

    /// The enablement status of the connector.
    enablement_status: ?CspmEnablementStatus = null,

    /// The name of the connector.
    name: ?[]const u8 = null,

    /// A summary of the cloud provider configuration for the connector.
    provider_summary: ?CspmProviderSummary = null,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .enablement_status = "EnablementStatus",
        .name = "Name",
        .provider_summary = "ProviderSummary",
    };
};
