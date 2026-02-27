const IngestionType = @import("ingestion_type.zig").IngestionType;
const IngestionState = @import("ingestion_state.zig").IngestionState;

/// Contains information about an ingestion.
pub const Ingestion = struct {
    /// The name of the application.
    app: []const u8,

    /// The Amazon Resource Name (ARN) of the app bundle for the ingestion.
    app_bundle_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the ingestion.
    arn: []const u8,

    /// The timestamp of when the ingestion was created.
    created_at: i64,

    /// The type of the ingestion.
    ingestion_type: IngestionType,

    /// The status of the ingestion.
    state: IngestionState,

    /// The ID of the application tenant.
    tenant_id: []const u8,

    /// The timestamp of when the ingestion was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .app = "app",
        .app_bundle_arn = "appBundleArn",
        .arn = "arn",
        .created_at = "createdAt",
        .ingestion_type = "ingestionType",
        .state = "state",
        .tenant_id = "tenantId",
        .updated_at = "updatedAt",
    };
};
