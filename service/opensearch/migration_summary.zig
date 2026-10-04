const MigrationError = @import("migration_error.zig").MigrationError;
const MigrationSource = @import("migration_source.zig").MigrationSource;

/// A summary of a migration job, including its status and progress.
pub const MigrationSummary = struct {
    /// The unique identifier of the OpenSearch application associated with the
    /// migration.
    application_id: ?[]const u8 = null,

    /// The date and time when the migration job was created.
    created_at: ?i64 = null,

    /// Error details if the migration failed or completed with errors.
    @"error": ?MigrationError = null,

    /// The number of saved objects exported from the source data source.
    exported_count: i32 = 0,

    /// The number of saved objects successfully imported into the target workspace.
    imported_count: i32 = 0,

    /// The unique identifier of the migration job.
    migration_id: ?[]const u8 = null,

    /// The source configuration for the migration.
    source: ?MigrationSource = null,

    /// The current status of the migration job.
    status: ?[]const u8 = null,

    /// The date and time when the migration job was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .created_at = "createdAt",
        .@"error" = "error",
        .exported_count = "exportedCount",
        .imported_count = "importedCount",
        .migration_id = "migrationId",
        .source = "source",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
