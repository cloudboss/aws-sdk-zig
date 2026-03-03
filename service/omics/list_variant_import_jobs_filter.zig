const JobStatus = @import("job_status.zig").JobStatus;

/// A filter for variant import jobs.
pub const ListVariantImportJobsFilter = struct {
    /// A status to filter on.
    status: ?JobStatus = null,

    /// A store name to filter on.
    store_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .store_name = "storeName",
    };
};
