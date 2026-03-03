const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IntegrationType = @import("integration_type.zig").IntegrationType;

/// This structure contains information about one CloudWatch Logs integration.
/// This
/// structure is returned by a
/// [ListIntegrations](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListIntegrations.html) operation.
pub const IntegrationSummary = struct {
    /// The name of this integration.
    integration_name: ?[]const u8 = null,

    /// The current status of this integration.
    integration_status: ?IntegrationStatus = null,

    /// The type of integration. Integrations with OpenSearch Service have the type
    /// `OPENSEARCH`.
    integration_type: ?IntegrationType = null,

    pub const json_field_names = .{
        .integration_name = "integrationName",
        .integration_status = "integrationStatus",
        .integration_type = "integrationType",
    };
};
