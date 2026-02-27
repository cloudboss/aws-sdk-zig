const IngestionState = @import("ingestion_state.zig").IngestionState;

/// Contains a summary of an ingestion.
pub const IngestionSummary = struct {
    /// The name of the application.
    app: []const u8,

    /// The Amazon Resource Name (ARN) of the ingestion.
    arn: []const u8,

    /// The status of the ingestion.
    state: IngestionState,

    /// The ID of the application tenant.
    tenant_id: []const u8,

    pub const json_field_names = .{
        .app = "app",
        .arn = "arn",
        .state = "state",
        .tenant_id = "tenantId",
    };
};
