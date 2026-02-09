const ExportStatus = @import("export_status.zig").ExportStatus;
const ExportType = @import("export_type.zig").ExportType;

/// Summary information about an export task.
pub const ExportSummary = struct {
    /// The Amazon Resource Name (ARN) of the export.
    export_arn: ?[]const u8,

    /// Export can be in one of the following states: IN_PROGRESS, COMPLETED, or
    /// FAILED.
    export_status: ?ExportStatus,

    /// The type of export that was performed. Valid values are `FULL_EXPORT` or
    /// `INCREMENTAL_EXPORT`.
    export_type: ?ExportType,
};
