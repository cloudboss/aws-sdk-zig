/// Filters for listing mapping update jobs.
pub const ListNetworkMigrationMappingUpdatesFilters = struct {
    /// A list of job IDs to filter by.
    job_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .job_i_ds = "jobIDs",
    };
};
