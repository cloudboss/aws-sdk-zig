const ExportStatus = @import("export_status.zig").ExportStatus;

/// Summary statuses of an archive export job.
pub const ExportSummary = struct {
    /// The unique identifier of the export job.
    export_id: ?[]const u8,

    /// The current status of the export job.
    status: ?ExportStatus,

    pub const json_field_names = .{
        .export_id = "ExportId",
        .status = "Status",
    };
};
