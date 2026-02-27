const ProviderSummary = @import("provider_summary.zig").ProviderSummary;

/// A condensed overview of the connectorV2..
pub const ConnectorSummary = struct {
    /// The Amazon Resource Name (ARN) of the connectorV2.
    connector_arn: ?[]const u8,

    /// The UUID of the connectorV2 to identify connectorV2 resource.
    connector_id: []const u8,

    /// ISO 8601 UTC timestamp for the time create the connectorV2.
    created_at: i64,

    /// The description of the connectorV2.
    description: ?[]const u8,

    /// The Name field contains the user-defined name assigned to the integration
    /// connector. This helps identify and manage multiple connectors within
    /// Security Hub.
    name: []const u8,

    /// The connectorV2 third party provider configuration summary.
    provider_summary: ProviderSummary,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .connector_id = "ConnectorId",
        .created_at = "CreatedAt",
        .description = "Description",
        .name = "Name",
        .provider_summary = "ProviderSummary",
    };
};
