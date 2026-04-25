/// Filters for listing import file enrichment jobs.
pub const ListImportFileEnrichmentsFilters = struct {
    /// A list of job IDs to filter by.
    job_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .job_i_ds = "jobIDs",
    };
};
