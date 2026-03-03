const ExportStatus = @import("export_status.zig").ExportStatus;
const ExportType = @import("export_type.zig").ExportType;

/// Summary information about an export task.
pub const ExportSummary = struct {
    /// The Amazon Resource Name (ARN) of the export.
    export_arn: ?[]const u8 = null,

    /// Export can be in one of the following states: IN_PROGRESS, COMPLETED, or
    /// FAILED.
    export_status: ?ExportStatus = null,

    /// The type of export that was performed. Valid values are `FULL_EXPORT` or
    /// `INCREMENTAL_EXPORT`.
    export_type: ?ExportType = null,

    pub const json_field_names = .{
        .export_arn = "ExportArn",
        .export_status = "ExportStatus",
        .export_type = "ExportType",
    };
};
