const ExportStatus = @import("export_status.zig").ExportStatus;

/// Summary information about an export, including its unique identifier,
/// current status,
/// creation time, and the domain being exported.
pub const ExportSummary = struct {
    /// The name of the domain for which the export was created.
    domain_name: []const u8,

    /// Unique ARN identifier of the export.
    export_arn: []const u8,

    /// The current state of the export. Current possible values include : PENDING -
    /// export request received,
    /// IN_PROGRESS - export is being processed, SUCCEEDED - export completed
    /// successfully, and FAILED - export encountered an error.
    export_status: ExportStatus,

    /// Timestamp when the export request was received by the service
    requested_at: i64,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .export_arn = "exportArn",
        .export_status = "exportStatus",
        .requested_at = "requestedAt",
    };
};
