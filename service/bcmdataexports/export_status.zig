const ExportStatusCode = @import("export_status_code.zig").ExportStatusCode;
const ExecutionStatusReason = @import("execution_status_reason.zig").ExecutionStatusReason;

/// The status of the data export.
pub const ExportStatus = struct {
    /// The timestamp of when the export was created.
    created_at: ?i64 = null,

    /// The timestamp of when the export was last generated.
    last_refreshed_at: ?i64 = null,

    /// The timestamp of when the export was updated.
    last_updated_at: ?i64 = null,

    /// The status code for the request.
    status_code: ?ExportStatusCode = null,

    /// The description for the status code.
    status_reason: ?ExecutionStatusReason = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_refreshed_at = "LastRefreshedAt",
        .last_updated_at = "LastUpdatedAt",
        .status_code = "StatusCode",
        .status_reason = "StatusReason",
    };
};
