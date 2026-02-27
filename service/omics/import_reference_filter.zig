const ReferenceImportJobStatus = @import("reference_import_job_status.zig").ReferenceImportJobStatus;

/// A filter for import references.
pub const ImportReferenceFilter = struct {
    /// The filter's start date.
    created_after: ?i64,

    /// The filter's end date.
    created_before: ?i64,

    /// A status to filter on.
    status: ?ReferenceImportJobStatus,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .status = "status",
    };
};
