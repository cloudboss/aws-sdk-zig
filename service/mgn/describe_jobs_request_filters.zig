/// Request to describe Job log filters.
pub const DescribeJobsRequestFilters = struct {
    /// Request to describe Job log filters by date.
    from_date: ?[]const u8,

    /// Request to describe Job log filters by job ID.
    job_i_ds: ?[]const []const u8,

    /// Request to describe job log items by last date.
    to_date: ?[]const u8,

    pub const json_field_names = .{
        .from_date = "fromDate",
        .job_i_ds = "jobIDs",
        .to_date = "toDate",
    };
};
