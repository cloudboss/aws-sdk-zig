pub const ListJobsResponse = struct {
    /// The names of all jobs in the account, or the jobs with the specified tags.
    job_names: ?[]const []const u8 = null,

    /// A continuation token, if the returned list does not contain the
    /// last metric available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_names = "JobNames",
        .next_token = "NextToken",
    };
};
