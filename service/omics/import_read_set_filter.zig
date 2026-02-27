const ReadSetImportJobStatus = @import("read_set_import_job_status.zig").ReadSetImportJobStatus;

/// A filter for import read set jobs.
pub const ImportReadSetFilter = struct {
    /// The filter's start date.
    created_after: ?i64,

    /// The filter's end date.
    created_before: ?i64,

    /// A status to filter on.
    status: ?ReadSetImportJobStatus,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .status = "status",
    };
};
