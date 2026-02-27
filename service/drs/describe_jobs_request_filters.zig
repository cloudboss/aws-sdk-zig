/// A set of filters by which to return Jobs.
pub const DescribeJobsRequestFilters = struct {
    /// The start date in a date range query.
    from_date: ?[]const u8,

    /// An array of Job IDs that should be returned. An empty array means all jobs.
    job_i_ds: ?[]const []const u8,

    /// The end date in a date range query.
    to_date: ?[]const u8,

    pub const json_field_names = .{
        .from_date = "fromDate",
        .job_i_ds = "jobIDs",
        .to_date = "toDate",
    };
};
