const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ExportSqlDetails = @import("export_sql_details.zig").ExportSqlDetails;
const Progress = @import("progress.zig").Progress;

/// Provides information about a schema conversion action.
pub const SchemaConversionRequest = struct {
    @"error": ?ErrorDetails,

    export_sql_details: ?ExportSqlDetails,

    /// The migration project ARN.
    migration_project_arn: ?[]const u8,

    progress: ?Progress,

    /// The identifier for the schema conversion action.
    request_identifier: ?[]const u8,

    /// The schema conversion action status.
    status: ?[]const u8,

    pub const json_field_names = .{
        .@"error" = "Error",
        .export_sql_details = "ExportSqlDetails",
        .migration_project_arn = "MigrationProjectArn",
        .progress = "Progress",
        .request_identifier = "RequestIdentifier",
        .status = "Status",
    };
};
