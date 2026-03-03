const ReadSetExportJobStatus = @import("read_set_export_job_status.zig").ReadSetExportJobStatus;

/// An read set export job filter.
pub const ExportReadSetFilter = struct {
    /// The filter's start date.
    created_after: ?i64 = null,

    /// The filter's end date.
    created_before: ?i64 = null,

    /// A status to filter on.
    status: ?ReadSetExportJobStatus = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .status = "status",
    };
};
